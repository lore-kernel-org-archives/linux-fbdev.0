From: "Andrew Wade" <andrew.j.wade@gmail.com>
Subject: Re: 2.6.19-rc4-mm2
Date: Mon, 6 Nov 2006 17:02:26 -0500
Message-ID: <610823610611061402g1d7811abhbf2479fa63f2970d@mail.gmail.com>
References: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A040@EXNA.corp.stratus.com>
Reply-To: ajwade@alumni.uwaterloo.ca
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753841AbWKFWCa@vger.kernel.org>
In-Reply-To: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A040@EXNA.corp.stratus.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, Kimball Murray <kimball.murray@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

On 11/6/06, Richardson, Charlotte <Charlotte.Richardson@stratus.com> wrote:
> What's the device id of your VC1?

I presume lscpi -n -v will tell you what you need to know. I don't know
how to read the output myself:

0000:01:00.0 0300: 1002:5157
        Subsystem: 1002:013a
        Flags: bus master, stepping, 66MHz, medium devsel, latency 64, IRQ 16
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        I/O ports at d800 [size=256]
        Memory at d7000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at d7fe0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

My card is a dual-head card, but I'm only using one head. On that head, if
I switch to virtual console 1, everything is fine, but if I switch to any
other vitual console, the display is "garbled": each row of pixels is offset
from the row before, producing interlaced "ghost" images.

I hope this helps; feel free to ask further questions.

-ajw
