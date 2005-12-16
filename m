From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: Re: Re: i810fb_blank
Date: Fri, 16 Dec 2005 01:55:17 -0200
Message-ID: <200512160155.17019.lucasvr@gobolinux.org>
References: <200512151614.44766.lucasvr@gobolinux.org> <43A1F906.4060608@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1En6hA-0006m7-Lc
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Dec 2005 19:55:48 -0800
Received: from itapoa.terra.com.br ([200.176.10.194])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1En6h9-0004mC-FE
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Dec 2005 19:55:48 -0800
In-Reply-To: <43A1F906.4060608@gmail.com>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

On Thursday 15 December 2005 21:15, Antonino A. Daplas wrote:
> Lucas Correia Villa Real wrote:
> > Hi!
> >
> > While looking at i810fb_blank() on 2.4 and 2.6, I've seen that
> > there's a difference on how pwr mask is handled: 2.4 unsets
> > the pwr bit on FB_BLANK_VSYNC_SUSPEND and
> > FB_BLANK_HSYNC_SUSPEND commands, while 2.6 turns that bit on.
> > Was that modification expected, or was it a typo? The attached
> > patch shows the code in question.
>
> That's the expected change.  We only want to completely power
> down the adapter on the deepest powersaving mode.
>
> Are you experiencing any problems with the new/old code?

A fellow worker has been working with software suspend 2 on a set 
top box which has an i810 card. The suspend command was not making 
the card to power off, so I looked at the code to give him a help, 
when I saw that different behaviour from 2.4 (2.4 hasn't been 
tested there, though).

I haven't seen this guy since then, so I don't know if that change 
did the trick for him. I'll let you know as soon as possible.

Thanks for the help!

-- 
Lucas
powered by /dev/dsp


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
