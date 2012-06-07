# This is an example PKGBUILD file. Use this as a start to creating your own,
# and remove these comments. For more information, see 'man PKGBUILD'.
# NOTE: Please fill out the license field for your package! If it is unknown,
# then please put 'unknown'.

# See http://wiki.archlinux.org/index.php/VCS_PKGBUILD_Guidelines
# for more information on packaging from Bazaar sources.

# Maintainer: Your Name <youremail@domain.com>
pkgname=UMC
pkgver=3.8
pkgrel=1
pkgdesc="UML Model Checker"
srcdir="umcv38"
arch=('i686' 'x86_64')
url="http://fmtlab.isti.cnr.it/umc"
license=('GPL')
groups=()
depends=(gcc-ada)
makedepends=('tar')
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=
source=(http://fmtlab.isti.cnr.it/umc/UMCDISTR/src-umc-38.tar)
noextract=()
md5sums=(5109df031afb0f119a43082cebc3f09f) 


build() {
  cd "${srcdir}"
  gnatmake -gnat05 umc
}

package() {
  cd "${srcdir}"
  mkdir -p "$pkgdir/usr/local/bin/" 
  cp umc "$pkgdir/usr/local/bin/umlmodelchecker"
}

# vim:set ts=2 sw=2 et:
