// Copyright 2024 Google LLC

//! The dump_modem binary is used to capture kernel/userspace logs in bugreport

use std::fs;

const MODEM_STAT: &str = "/data/vendor/modem_stat/debug.txt";
const SSRDUMP_DIR: &str = "/data/vendor/ssrdump";
const RFSD_ERR_LOG_DIR: &str = "/data/vendor/log/rfsd";
const WAKEUP_EVENTS: &str = "/sys/devices/platform/cpif/wakeup_events";
const CPIF_LOGBUFFER: &str = "/dev/logbuffer_cpif";
const PCIE_EVENT_STATS: &str = "/sys/devices/platform/cpif/modem/pcie_event_stats";

fn handle_io_error(file: &str, err: std::io::Error) {
    match err.kind() {
        std::io::ErrorKind::NotFound => println!("{file} not found!"),
        std::io::ErrorKind::PermissionDenied => println!("Permission denied to access {file}"),
        _ => println!("I/O error accessing {file}: {err}"),
    }
}

fn print_file(file: &str) -> Result<(), std::io::Error> {
    fs::metadata(file)?;

    let data = fs::read_to_string(file)?;

    if data.is_empty() {
        println!("{file} is empty");
    } else {
        print!("{data}");
    }

    Ok(())
}

fn print_file_and_handle_error(file: &str) {
    if let Err(err) = print_file(file) {
        handle_io_error(file, err);
    }
}

fn print_matching_files_in_dir(dir: &str, filename: &str) {
    let Ok(entries) = fs::read_dir(dir) else {
        return println!("Cannot open directory {dir}");
    };

    for entry in entries {
        let Ok(entry) = entry else {
            continue;
        };
        if entry.path().is_file() && entry.file_name().to_string_lossy().starts_with(filename) {
            if let Some(path_str) = entry.path().to_str() {
                println!("{}", path_str);
                print_file_and_handle_error(path_str);
            }
        }
    }
}

// Capture modem stat log if it exists
fn modem_stat() {
    println!("------ Modem Stat ------");
    print_file_and_handle_error(MODEM_STAT);
    println!();
}

// Capture crash signatures from all modem crashes
fn modem_ssr_history() {
    println!("------ Modem SSR history ------");
    print_matching_files_in_dir(SSRDUMP_DIR, "crashinfo_modem");
    println!();
}

// Capture rfsd error logs from all existing log files
fn rfsd_error_log() {
    println!("------ RFSD error log ------");
    print_matching_files_in_dir(RFSD_ERR_LOG_DIR, "rfslog");
    println!();
}

// Capture modem wakeup events if the sysfs attribute exists
fn wakeup_events() {
    println!("------ Wakeup event counts ------");
    print_file_and_handle_error(WAKEUP_EVENTS);
    println!();
}

// Capture kernel driver logbuffer if it exists
fn cpif_logbuffer() {
    println!("------ CPIF Logbuffer ------");
    print_file_and_handle_error(CPIF_LOGBUFFER);
    println!();
}

// Capture modem pcie stats if the sysfs attribute exists
fn pcie_event_stats() {
    println!("------ PCIe event stats ------");
    print_file_and_handle_error(PCIE_EVENT_STATS);
    println!();
}

fn main() {
    modem_stat();
    modem_ssr_history();
    rfsd_error_log();
    wakeup_events();
    cpif_logbuffer();
    pcie_event_stats();
}
