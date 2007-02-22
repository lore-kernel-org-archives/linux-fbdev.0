From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: no backlight on radeon after recent kernel "upgrade"s
Date: Wed, 21 Feb 2007 22:51:22 -0200
Message-ID: <20070222005122.GA7928@khazad-dum.debian.net>
References: <20070219044616.GC25659@washoe.onerussian.com> <20070219000412.acad13de.akpm@linux-foundation.org> <1171876788.6046.3.camel@localhost.localdomain> <877iub9mu2.fsf@sycorax.lbl.gov> <1172097718.5790.29.camel@localhost.localdomain> <20070221231706.GA3336@khazad-dum.debian.net> <1172103159.5790.45.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932775AbXBVAve@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1172103159.5790.45.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Alex Romosan <romosan@sycorax.lbl.gov>, Yaroslav Halchenko <kernel@onerussian.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

On Thu, 22 Feb 2007, Richard Purdie wrote:
> I have a thinkpad with Intel GM graphics ;-). I need it to work so I try
> not to experiment too much on it. I've just tried the ibm-acpi driver
> and it doesn't work well :-(.

2.6.21-rc, or 2.6.20?  If it is in 2.6.21, could you give me a report of how
it fares on 2.6.20?

> * 'cat brightness' != 'cat actual_brightness' upon bootup (doesn't have

Hmm, I see this in 2.6.20 too.  And brightness is the one that is buggy.  I
will look into it.

> * 'echo 0 > brightness' lowered the intensity but by a level or two, not
> set it to level 0. A couple of more attempts and it did jump from 7 -> 1
> and so on, it seems erratic.

I know it used to work fine before 2.6.20.  Let me check...  works fine on a
T43, 2.6.20 (Radeon X300).  I need more data to fix it :-)

> actual_brightness always seems to be correct, as does brightness so it
> looks like its not updating the hardware correctly.

Well, if you have the ACPI video module loaded, unload it.  Does it work
now?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
