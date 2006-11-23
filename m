From: Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
Date: 23 Nov 2006 04:08:29 -0500
Message-ID: <yq0k61mv8c2.fsf@jaguar.mkp.net>
References: <20061118000235.GV31879@stusta.de>
	<Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933316AbWKWJIc@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de>
Cc: Adrian Bunk <bunk@stusta.de>, adaplas@pol.net, James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, geert@linux-m68k.org, zippel@linux-m68k.org, linux-m68k@vger.kernel.org, linuxppc-dev@ozlabs.org, sammy@sammy.net, sun3-list@redhat.com

>>>>> "Michael" == Michael Schmitz <schmitz@mail.biophys.uni-duesseldorf.de> writes:

Michael> On Sat, 18 Nov 2006, Adrian Bunk wrote:
>> This patch removes video drivers that: - had already been marked as
>> BROKEN in 2.6.0 three years ago and - are still marked as BROKEN.
>> 
>> These are the following drivers: - FB_CYBER - FB_VIRGE -
>> FB_RETINAZ3 - FB_ATARI

Michael> FB_ATARI has just been revived. Geert has a preliminary
Michael> patch; I'll send the final one soonish.

I'm probably the only one with a RetinaZ3 left but the machine hasn't
been booted for quite a while..... not sure if I'll get to it in the
near future, but I can always resurrect the patches from an old kernel
and start from there if I do.

Jes
