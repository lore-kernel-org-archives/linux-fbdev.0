From: Richard Smith <rsmith@bitworks.com>
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video
 card BOOT?
Date: Thu, 21 Oct 2004 15:47:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <41782070.4070303@bitworks.com>
References: <41764FB3.29782.1B9A13F4@localhost> <4177AD6B.23151.20F0292D@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268778AbUJUUsg@vger.kernel.org>
In-Reply-To: <4177AD6B.23151.20F0292D@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org

Kendall Bennett wrote:

>>One more question: Does 0xc0000 POST method work even on
>>notebooks? On regular machines, PCI card must have normal bios and
>>stuff is easy. On notebooks there was talk about "integrated bios"
>>where it really has no video bios at all and system bios POSTs the
>>card. Have you seen that? 

With all the video chips I've worked with the mfg gives me a binary 
formatted up as an option ROM and I'm responsible for getting it called.

> We have never had a need to POST a notebook Video BIOS so I don't know 
> what would happen. It is an interesting question, and if this is to be 
> used for resume operations something that should be investigated.
> 

What I've seen is that they simply place a copy of the video bios at the 
shadowed legacy vbios range usually 0xc0000 but it can be anywhere in 
the 0xc0000-0x0e0000 range.  Or physically locate the vbios in the 
onboard ROM such that it will show up in that range.

Then when the system bios goes through its scan of the legacy ranges 
looking for option roms it hits the video bios and runs it.

-- 
Richard A. Smith
