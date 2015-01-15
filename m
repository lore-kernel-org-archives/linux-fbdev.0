From: Noralf Tronnes <notro@tronnes.org>
Date: Thu, 15 Jan 2015 15:58:02 +0000
Subject: Is fbdev deprecated?
Message-Id: <54B7E38A.6000408@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi,

I've read several comments on this list that indicates that fbdev should=20
be avoided for new drivers.
I'm writing drivers for MIPI DBI type 1 compatible controllers with=20
onchip RAM.
This onchip memory is scanned out to the panel. So the driver just=20
sync's the
framebuffer with the controller memory (partial updates also).
I rely on deferred io to do this. The ssd1307fb is a similar type of driver.

Is this still a use case for fbdev, or is DRM the only way now?

Here's a description of the driver stack:=20
https://github.com/notro/fbdbi/wiki


Regards,
Noralf Tr=F8nnes

