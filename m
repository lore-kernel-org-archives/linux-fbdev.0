From: "David Hollister" <David.Hollister@amd.com>
Subject: Re: [PATCH] fbcon: Fix scrollback with logo
 issue immediately after boot
Date: Thu, 25 May 2006 07:32:04 -0600
Message-ID: <1148563924.8442.2.camel@localhost>
References: <20060524194128.GA2680@cosmic.amd.com>
 <4474FBC0.5050806@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FjFwf-0006I5-B5
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 06:32:09 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FjFwe-0008Ip-SM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 06:32:08 -0700
Received: from amdext4.amd.com ([163.181.251.6])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FjFwc-0002EQ-6H
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 06:32:08 -0700
In-Reply-To: <4474FBC0.5050806@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, jordan.crouse@amd.com

Hi Antonino,

That sounds exactly like what I was seeing.  Oddly enough, as that post
explains, the problem did not manifest at all resolutions.  The short
answer is yes, I believe this patch will fix the issue referenced below.

David

On Thu, 2006-05-25 at 08:35 +0800, Antonino A. Daplas wrote:
> Jordan Crouse wrote:
> > Greeting folks -
> > 
> > Sending on a patch against latest git that attempts to fix an issue with
> > the scrollback buffer in the fbcon immediately after boot.    As always,
> > comments welcome.
> 
> Looks sane.  Does this patch fix the problem mentioned here?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114821885109864&w=2
> 
> Tony
> 
> 
> 




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
