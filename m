From: James Simmons <jsimmons@infradead.org>
Subject: Re: Newest fbdev patch to go mainline.
Date: Tue, 10 Feb 2004 17:49:52 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402101747450.6600-100000@phoenix.infradead.org>
References: <20040210173551.GC27779@kroah.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aqc1J-0000ie-Eu
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 09:50:01 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Aqc0j-0005Tw-SS
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 09:49:26 -0800
In-Reply-To: <20040210173551.GC27779@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



Thats coming :-) The problem only showes itself with modular drivers 
correct. So I will submit patches for those first. I just wanted to polish 
off a few really tiny patches fist.

On Tue, 10 Feb 2004, Greg KH wrote:

> On Tue, Feb 10, 2004 at 06:36:03AM +0000, James Simmons wrote:
> > 
> > First step to incorporate the new cursor api. It s abig patch so I broke 
> > it into pieces. Give it a try.
> 
> How about fixing up the problem in the in-kernel version of fb that Al
> Viro and I pointed out?
> 
> thanks,
> 
> greg k-h
> 



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
