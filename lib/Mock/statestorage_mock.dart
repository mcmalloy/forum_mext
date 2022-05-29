class StateStorageMock {

  bool hasAccessToken() {
    return true;
  }

  bool NoAccessToken() {
    return false;
  }

  String lastSelectedMunicipality() {
    return "Rudersdal";
  }

}
