From: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: CONFIG_VIDEO_SELECT stole my will to live
Date: Tue, 20 May 2003 16:51:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030520155138.GA29450@suse.de>
References: <Pine.LNX.4.44.0305210002210.19743-100000@bad-sports.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305210002210.19743-100000@bad-sports.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brett <generica@email.com>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, May 21, 2003 at 12:14:50AM +1000, Brett wrote:

 > since 2.5.67-bk5. I have been unable to boot my laptop
 > tonight, I finally traced it back to
 > http://linux.bkbits.net:8080/linux-2.5/cset@1.1006

good work.

 > the video card is a chips and tech 65545
 > i'd just like to know where to go from here, so that I can return to 
 > booting with CONFIG_VIDEO_SELECT set 

Possibly the card's VGA BIOS has 'issues' with that call.

Wasn't the EDID stuff getting backed out anyways ?

		Dave
