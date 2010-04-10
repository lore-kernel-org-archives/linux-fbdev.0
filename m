From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH 02/16] viafb: use proper pci config API
Date: Sat, 10 Apr 2010 08:41:39 +0200
Message-ID: <20100410064139.GS14576@prithivi.gnumonks.org>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
 <1270746946-12467-3-git-send-email-corbet@lwn.net>
 <4BBE2389.5010802@gmx.de>
 <20100409134610.0b610f93@bike.lwn.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100409134610.0b610f93@bike.lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-kernel@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

Hi Jon + Florian,

On Fri, Apr 09, 2010 at 01:46:10PM -0600, Jonathan Corbet wrote:
> On Thu, 08 Apr 2010 20:42:17 +0200
> Florian Tobias Schandinat <FlorianSchandinat@gmx.de> wrote:
> 
> > something I am wondering about is whether we can't simply do:
> > viaparinfo->memsize = pci_resource_len(pdev, 0);
> > I suppose that this is not possible meaning that the pci len can be 
> > longer than the actual memory but I just wanted to use the moment to 
> > make sure.
> 
> That would make sense.  But if somebody who is closer to the hardware than
> I am doesn't take that approach, I'm nervous about changing it.  Harald?

I believe it is not safe to simply use the pci_resource_len(pdev, 0).

At least in some of the hardware I've been working with in the past, the
PCI resource length was always fixed, independent of how large the BIOS
configured the shared video memory.

So please don't use that method.

Regards,
	Harald
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
