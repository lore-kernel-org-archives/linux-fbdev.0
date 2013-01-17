From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Thu, 17 Jan 2013 13:37:44 +0000
Subject: Re: DirectFB on RV710
Message-Id: <1358429864.6572.22.camel@thor.local>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Don, 2013-01-17 at 19:34 +0800, "李真能" wrote: 
> Kernel supports RV710 in drivers/gpu/drm/radeon(r600),but I want gpu
> acceleration in framebuffer for RV710 to use in directfb, I try to migrate
> code from drivers/gpu/drm/radeon to drivers/video/aty/ to support
> directfb, but it's very difficulty, because I have not the datasheet for
> RV710, I don't konw how to set registers to draw a line, or a rectangle,
> if someone has the datasheet for rv710, please sent me, thanks very
> much!!!

RV710 doesn't have a 2D engine, so you'd have to use the 3D engine.
There are some links to documentation for this on
http://wiki.x.org/wiki/RadeonFeature .


-- 
Earthling Michel Dänzer           |                   http://www.amd.com
Libre software enthusiast         |          Debian, X and DRI developer
