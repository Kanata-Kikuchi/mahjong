# 修正版パス設定
from pathlib import Path
import cv2, os

# 現在のスクリプトから見た相対パスに修正
INPUT_DIR = Path("assets/images")
OUTPUT_DIR = Path("assets/images_82x119")
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


TARGET_W, TARGET_H = 82, 119

def resize_keep_alpha(src_path: Path, dst_path: Path):
    img = cv2.imread(str(src_path), cv2.IMREAD_UNCHANGED)  # 透過保持
    if img is None:
        print(f"読み込み失敗: {src_path}")
        return
    h, w = img.shape[:2]
    if (w, h) == (TARGET_W, TARGET_H):
        # すでに82x119ならそのままコピー保存
        cv2.imwrite(str(dst_path), img)
        print(f"スキップ(同サイズ): {src_path.name}")
        return
    # 縮小向け: INTER_AREA （高品質なら INTER_LANCZOS4 でも可）
    resized = cv2.resize(img, (TARGET_W, TARGET_H), interpolation=cv2.INTER_AREA)
    cv2.imwrite(str(dst_path), resized)
    print(f"{src_path.name}: {w}x{h} -> {TARGET_W}x{TARGET_H}")

def main():
    pngs = sorted(INPUT_DIR.glob("*.png"))
    if not pngs:
        print(f"PNGが見つかりません: {INPUT_DIR}")
        return
    for p in pngs:
        # そのまま全部対象（back.png も含む）。除外したければ以下で continue する:
        # if p.name.lower() == "back.png": continue
        dst = OUTPUT_DIR / p.name
        resize_keep_alpha(p, dst)
    print(f"\n✅ 変換完了。出力: {OUTPUT_DIR}")

if __name__ == "__main__":
    main()
