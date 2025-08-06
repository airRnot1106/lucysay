{
  buildGleamApplication,
}:
buildGleamApplication {
  pname = "lucysay";
  version = "0.1.0";

  src = ../..;

  target = "javascript";
}
