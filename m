From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [forum] Re: Announcement: Modification to the base XFree86(TM) license.
Date: Fri, 30 Jan 2004 18:32:38 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040130173238.GA8599@iliana>
References: <20040129115838.A70069@xfree86.org> <1075423804.12536.28.camel@gaston> <16410.33783.236964.200047@xf11.fra.suse.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AmcW4-0007ha-3G
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Jan 2004 09:33:16 -0800
Received: from smtp4.wanadoo.fr ([193.252.22.27] helo=mwinf0401.wanadoo.fr)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AmcW3-00074E-4N
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Jan 2004 09:33:15 -0800
Content-Disposition: inline
In-Reply-To: <16410.33783.236964.200047@xf11.fra.suse.de>
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
To: forum@xfree86.org
Cc: devel@XFree86.Org, linux-fbdev-devel@lists.sourceforge.net

On Fri, Jan 30, 2004 at 05:19:03PM +0100, Egbert Eich wrote:
> Benjamin Herrenschmidt writes:
> 
>  > Losing the ability of porting code straight from these to the fbdev
>  > drivers will basically kill all my efforts to turn the kernel radeonfb
>  > into a decent driver as I need to be able to re-use the code ATI puts
>  > in the XFree version. I suppose the same will happen to linux rivafb.
> 
> Relating to that: exchanging code between XFree86 and kernel has been a
> one-way road so far. The GPL the kernel is under doesn't allow us to
> port back improvements that have been made to the kernel to our drivers
> Even though this isn't covered by the GPL the author of the driver 
> or the changes could still give the permission to do so.
> 
> I whish there was a better exchange between kernel fbdev developers
> and driver developers here.

Maybe a decision on both parts on this would be ok ? XFree86 could make
sure the licence of the driver code would not conflict with the GPL,
keeping the old one for example, and the fbdev driver authors would
dual-licence the code, both GPL and the old xfree86 licence would do
just fine. Benjamin, what do you think about this ?

BTW, CCing this to the linux-fbdev mailing list.

Friendly,

Sven Luther


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
