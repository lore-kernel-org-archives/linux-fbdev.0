From: Greg KH <greg@kroah.com>
Subject: Re: Newest fbdev patch to go mainline.
Date: Tue, 10 Feb 2004 09:35:51 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040210173551.GC27779@kroah.com>
References: <Pine.LNX.4.44.0402100634430.32169-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aqbud-0007aN-OW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 09:43:07 -0800
Received: from mail.kroah.org ([65.200.24.183] helo=perch.kroah.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Aqbu4-0003c0-I3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 09:42:32 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402100634430.32169-100000@phoenix.infradead.org>
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 10, 2004 at 06:36:03AM +0000, James Simmons wrote:
> 
> First step to incorporate the new cursor api. It s abig patch so I broke 
> it into pieces. Give it a try.

How about fixing up the problem in the in-kernel version of fb that Al
Viro and I pointed out?

thanks,

greg k-h


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
