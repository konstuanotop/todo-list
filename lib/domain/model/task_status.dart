enum TaskStatus {
  process,
  done;

  bool get isDone => this == done;
  bool get isProcces => this == process;
}
