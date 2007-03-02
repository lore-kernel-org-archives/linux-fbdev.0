From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: 2.6.21-rc2 radeon backlight
Date: Fri, 2 Mar 2007 18:01:57 -0300
Message-ID: <20070302210157.GA11786@khazad-dum.debian.net>
References: <20070301184531.b3aeafe3.akpm@linux-foundation.org> <87tzx35zkc.fsf@sycorax.lbl.gov> <20070302122920.a2967ebf.akpm@linux-foundation.org> <20070302.123514.35465791.davem@davemloft.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965618AbXCBVCK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070302.123514.35465791.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, romosan@sycorax.lbl.gov, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, rpurdie@rpsys.net

On Fri, 02 Mar 2007, David Miller wrote:
> Why don't we compromise for 2.6.21 by marking the Radeon backlight
> stuff EXPERIMENTAL until the cases where IBM ACPI works and the
> Radeon backlight stuff does not are worked out?

What ibm-acpi backlight control does is *very* different from what the
radeon backlight control does.

ibm-acpi talks to the ThinkPad EC to change the brightness of the backlight,
it has *NO* on/off support.  Radeon talks to the video chipset to turn the
LVDS output on/off (or something to that effect), and thus to turn the
backlight on/off.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
