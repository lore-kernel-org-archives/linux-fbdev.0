From: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: drivers/video/aty/radeon_backlight.c
Date: Wed, 13 Dec 2006 15:29:30 +0100
Message-ID: <20061213142930.GA12686@hansmi.ch>
References: <m3irgflxh4.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964869AbWLMOgO@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <m3irgflxh4.fsf@lugabout.jhcloos.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Cloos <cloos@jhcloos.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 08:46:24AM -0500, James Cloos wrote:
> Are there any dependencies in $subject which would preclude changing
> drivers/video/Kconfig with:

Yes.

> or is radeon_backlight.c only functional when -DCONFIG_PMAC_BACKLIGHT,
> even though the pmac routines are all ifdef'ed?

Did you actually test wether it works? As far as I know, only Apple
(PowerPC) hardware uses these registers yet and have no use anywhere
else.

Greets,
Michael

-- 
Gentoo Linux developer, http://hansmi.ch/, http://forkbomb.ch/
