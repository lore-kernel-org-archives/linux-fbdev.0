From: Olaf Hering <olaf@aepfle.de>
Subject: Re: backlight: oops in __mutex_lock_slowpath during head /sys/class/graphics/fb0/* in 2.6.18
Date: Fri, 22 Sep 2006 13:26:22 +0200
Message-ID: <20060922112622.GA26724@aepfle.de>
References: <20060921121952.GA16927@aepfle.de> <20060921123742.ec225cc2.akpm@osdl.org> <20060921215620.GA9518@hansmi.ch>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751093AbWIVL1R@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060921215620.GA9518@hansmi.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@pol.net>, Daniel R Thompson <daniel.thompson@st.com>, Jon Smirl <jonsmirl@gmail.com>, akpm@osdl.org

On Thu, Sep 21, Michael Hanselmann wrote:

> What about the patch below? Does it work for you?

Appears to work.

tangerine:~ # head /sys/class/graphics/fb0/*
==> /sys/class/graphics/fb0/bits_per_pixel <==
8

==> /sys/class/graphics/fb0/bl_curve <==
head: error reading `/sys/class/graphics/fb0/bl_curve': No such device

==> /sys/class/graphics/fb0/blank <==

==> /sys/class/graphics/fb0/console <==

==> /sys/class/graphics/fb0/cursor <==

==> /sys/class/graphics/fb0/dev <==
29:0

==> /sys/class/graphics/fb0/mode <==

==> /sys/class/graphics/fb0/modes <==
U:832x624p-74

==> /sys/class/graphics/fb0/name <==
valkyrie

==> /sys/class/graphics/fb0/pan <==
0,0

==> /sys/class/graphics/fb0/rotate <==
0

==> /sys/class/graphics/fb0/state <==
0

==> /sys/class/graphics/fb0/stride <==
832

==> /sys/class/graphics/fb0/subsystem <==
head: error reading `/sys/class/graphics/fb0/subsystem': Is a directory
head: cannot open `/sys/class/graphics/fb0/uevent' for reading: Permission denied

==> /sys/class/graphics/fb0/virtual_size <==
832,624
