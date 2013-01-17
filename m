From: =?gb2312?Q?=22=C0=EE=D5=E6=C4=DC=22?= <lizhenneng@kylinos.com.cn>
Date: Thu, 17 Jan 2013 11:34:36 +0000
Subject: 
Message-Id: <917bc3ff7b9278f9070edb2af5924216.squirrel@mail.kylinos.com.cn>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Kernel supports RV710 in drivers/gpu/drm/radeon(r600),but I want gpu
acceleration in framebuffer for RV710 to use in directfb, I try to migrate
code from drivers/gpu/drm/radeon to drivers/video/aty/ to support
directfb, but it's very difficulty, because I have not the datasheet for
RV710, I don't konw how to set registers to draw a line, or a rectangle,
if someone has the datasheet for rv710, please sent me, thanks very
much!!!

