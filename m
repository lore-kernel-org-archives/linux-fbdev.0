From: Justin Mattock <justinmattock@gmail.com>
Date: Wed, 25 Aug 2010 21:12:50 +0000
Subject: vesafb not loading during boot and lilo gives no video modes
Message-Id: <AANLkTikw9y5sTHNfCq0qGfn_nyRpvQAm6Ezusneq5Umz@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lilo-devel@lists.debian.org

hello,
Ive been building a clfs system, and have been racking my brain around
as to why vesafb is not loading at boot.. using any option in
lilo.conf
(vga=3Dnormal,893,ask) gives nothing but the no modes found.

under dmesg on the machine that doesn't work I see
[    0.000000] Console: colour EGA 80x25

and on the good machine(same setup older packages)I see
[    0.000000] Console: colour dummy device 80x25

is there something Im missing in userspace to cause lilo to not
respond to vga=893, ask, normal but only go to EGA?

--=20
Justin P. Mattock
