From: Siim Vahtre <siim@pld.ttu.ee>
Subject: i810fb compile/module loading failure on 2.5.66-bk12
Date: Sun, 6 Apr 2003 18:34:57 +0300 (EET DST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.53.0304061824230.17774@pitsa.pld.ttu.ee>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net


When trying to load module i810 on 2.5.66-bk12 I get:
i810fb: Unknown symbol __memcpy

It also happens (in a bit different way) when I try to link it while
compiling directly into kernel.

I fixed it by changing
            memcpy_toio(d_addr, s_addr, s_pitch * image->height);
on drivers/video/i810/i810_accel.c:419 to:
            memcpy(d_addr, s_addr, s_pitch * image->height);

I have no idea what I've just done but... it works for me. :-)
