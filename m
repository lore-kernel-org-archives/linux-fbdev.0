From: jsimmons@pentafluge.infradead.org
Subject: Re: New fbdev patch.
Date: Wed, 30 Jun 2004 17:57:28 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0406301753470.29465@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0406231859390.27210@pentafluge.infradead.org>
 <40DC328C.9010707@bitworks.com> <20040629214850.GC2871@mercury.jahnsnet.de>
 <40E1ECCD.7080501@bitworks.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfiOw-0002Vk-PO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Jun 2004 09:57:38 -0700
Received: from [213.146.154.40] (helo=pentafluge.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1BfiOv-0001w9-PY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 30 Jun 2004 09:57:38 -0700
In-Reply-To: <40E1ECCD.7080501@bitworks.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Smith <rsmith@bitworks.com>
Cc: Thomas.Jahns@epost.de, fbdev <linux-fbdev-devel@lists.sourceforge.net>


Sorry about the deal. I'm in jolly old England right now. I plan to leave 
tomorrow, but before I go I have a new patch that will work against 
linux-2.6.7. Sorry the other patch was against Linus BK tree.

The correct patch is here.

http://www.infradead.org/~jsimmons/changes.diff.gz


On Tue, 29 Jun 2004, Richard Smith wrote:

> Thomas Jahns wrote:
> 
> 
> You only replied to me so I'm bouncing this to the list as well.  James 
> you want to retry your patch?
> 
> > Hi,
> > 
> > On 06/25/04 16:11:24, Richard Smith wrote:
> > 
> >> Has anyone else tried this?  A lot of it fails to apply for me.  I  
> >> pulled a clean 2.6.7 from kernel.org.
> >>
> >> A large portion of the diffs succeed but with an offset.
> > 
> > 
> > same here, and for some rejects I'm not even able to figure out where  
> > they are supposed to fit because no meaningful identifier in the  
> > context appears in the affected source files.
> > 
> > The individual parts of the patch reveal, that it's not against  
> > straight 2.6.7 but rather against Linus' current tree at that time.
> > 
> > Thomas Jahns
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by Black Hat Briefings & Training.
> Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
> digital self defense, top technical experts, no vendor pitches, 
> unmatched networking opportunities. Visit www.blackhat.com
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
