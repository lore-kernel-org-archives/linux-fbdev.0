From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: Re: [forum] Re: Announcement: Modification to the base XFree86(TM) license.
Date: Fri, 30 Jan 2004 23:29:02 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040130222902.GA11885@iliana>
References: <20040129115838.A70069@xfree86.org> <1075423804.12536.28.camel@gaston> <16410.33783.236964.200047@xf11.fra.suse.de> <20040130173238.GA8599@iliana> <16410.44981.237411.858354@xf11.fra.suse.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Amh8T-0008Oa-Pk
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Jan 2004 14:29:13 -0800
Received: from smtp1.wanadoo.fr ([193.252.22.30] helo=mwinf0101.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Amh8R-0005Le-8d
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Jan 2004 14:29:11 -0800
Content-Disposition: inline
In-Reply-To: <16410.44981.237411.858354@xf11.fra.suse.de>
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
To: Egbert Eich <eich@XFree86.Org>
Cc: forum@XFree86.Org, devel@XFree86.Org, linux-fbdev-devel@lists.sourceforge.net

On Fri, Jan 30, 2004 at 08:25:40PM +0100, Egbert Eich wrote:
> Sven Luther writes:
>  > 
>  > Maybe a decision on both parts on this would be ok ? XFree86 could make
>  > sure the licence of the driver code would not conflict with the GPL,
>  > keeping the old one for example, and the fbdev driver authors would
>  > dual-licence the code, both GPL and the old xfree86 licence would do
>  > just fine. Benjamin, what do you think about this ?
>  > 
>  > BTW, CCing this to the linux-fbdev mailing list.
>  > 
> 
> Yes, a personal agreement between driver developers would also work.
> However they tend to change and other people will make contributions
> who all would have to agree also. 
> I don't know if a general dual license agreement in the kernel 
> file header would be possible. Also it could get removed once 
> the author changes. Just like the license in the XFree86 driver 
> could be amended. 

I guess already some drivers have such a dual licencing.

> Doing this now for existing fbdev driver would involve to ask
> anyone who has contributed little more than a typo fix.

Yeah, that would be rather problematic, but anyway, most of the things
move from the XFree86 code to fbdev code, and most often, it is not code
that is copied, but the register information and such. It is always
easier to get specs if you are working for XFree86 than if you plan to
do some kernel driver work.

Friendly,

Sven Luther


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
