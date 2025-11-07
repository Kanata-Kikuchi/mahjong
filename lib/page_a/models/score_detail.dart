class ScoreDetail {
  final int reach;
  final int tsumo;
  final int ron;
  final int bakaze;
  final int zikaze;
  final int dora;
  final bool ippatsu;
  final int? agari;
  final int? score;
  final bool flagRon;
  final bool flagTsumo;
  
  const ScoreDetail({
    required this.reach,
    required this.tsumo,
    required this.ron,
    required this.bakaze,
    required this.zikaze,
    required this.dora,
    required this.ippatsu,
    required this.agari,
    required this.score,
    required this.flagRon,
    required this.flagTsumo
  });
}