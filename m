From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Dri-devel] Re: DRM and pci_driver conversion
Date: Thu, 23 Oct 2003 21:19:20 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3F987E18.9080606@pobox.com>
References: <Pine.LNX.4.44.0310231541000.3421-100000@home.osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0310231541000.3421-100000@home.osdl.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, dri-devel <dri-devel@lists.sourceforge.net>

Linus Torvalds wrote:
> [ Jeff: is that PCI ROM enable _really_ that complicated? Ouch. Or is
>   there some helper function I missed? ]


The mechanics aren't complicated, but I seem to recall there being a 
Real Good Reason why you want to leave it disabled 99% of the time.  No, 
I don't recall that reason :(  But my fuzzy memory seems to think that 
"enable, grab a slice o 'rom, disable" was viable.

	Jeff





-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
