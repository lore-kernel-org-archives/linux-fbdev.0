From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: no backlight on radeon after recent kernel "upgrade"s
Date: Wed, 21 Feb 2007 21:17:06 -0200
Message-ID: <20070221231706.GA3336@khazad-dum.debian.net>
References: <20070219044616.GC25659@washoe.onerussian.com> <20070219000412.acad13de.akpm@linux-foundation.org> <1171876788.6046.3.camel@localhost.localdomain> <877iub9mu2.fsf@sycorax.lbl.gov> <1172097718.5790.29.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423199AbXBUXRP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1172097718.5790.29.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Alex Romosan <romosan@sycorax.lbl.gov>, Yaroslav Halchenko <kernel@onerussian.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

On Wed, 21 Feb 2007, Richard Purdie wrote:
> enabled. On a thinkpad, the backlight is probably under ACPI control.

BIOS+ACPI, actually.  Without ACPI video loaded, the firmware does
everything correctly.  With ACPI video, the firmware does it, then its
changes are clobbered over by ACPI video's.

If ibm-acpi is loaded, a backlight device "ibm" is added.  ibm-acpi's ibm
backlight device can change the display brightness.  It is *not* capable of
turning the backlight on or off, AFAIK.

BTW, some ThinkPads don't have a Radeon, but rather an Intel GM/GMX device.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
