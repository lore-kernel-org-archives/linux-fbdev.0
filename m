From: "D.J.J. Ring, Jr." <n1ea@arrl.net>
Date: Sat, 12 Nov 2011 23:42:01 +0000
Subject: Getting FB to work in Console
Message-Id: <CADO5RbhunU1X7mWwGDbVRc1FSPKBaLudAVav0TMkBoQ_1zp0Mw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

I want to make framebuffer work in console only Debian installation.
I find many of the howto's on the web won't work for current Debian
Stable - or I'm just too stupid to figure them out.
< grin >

I want to get fbi and links2 -g working in console.

I tried entering in console:

sudo mknod /dev/fb0 c 29 0

But when I reboot /dev/fb0 does not exist.

I've had links2 -g working before - I've got libdirectfb-dev
libdirectfb-bin and all the files I can find with directfb to install.

I am working on Debian Stable command line only.

David
