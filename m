From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: query (critical problem)
Date: Fri, 16 Jul 2004 07:07:43 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407160707.46619.adaplas@hotpop.com>
References: <004a01c46a64$af896ef0$7c04b40a@dlh.st.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BlFLM-0005XQ-LV
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Jul 2004 16:08:48 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BlFLM-0007Nj-Av
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Jul 2004 16:08:48 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id D6C73693A15
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Jul 2004 22:22:15 +0000 (UTC)
In-Reply-To: <004a01c46a64$af896ef0$7c04b40a@dlh.st.com>
Content-Disposition: inline
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
To: Manish RATHI <manish.rathi@st.com>, linux-fbdev-devel@lists.sourceforge.net

On Thursday 15 July 2004 20:10, Manish RATHI wrote:
> Hi,
> I've ported linux on our chip using  linux kernel 2.4.20. On chip we have a
> display interface on which epson panel is attached. We've written a display
> driver using framebuffer driver as a upper layer.
>
> Problem with this driver is that due to framebuffer concept we don't know
> when data is updated in framebuffer as this is done by application.
>
> So we don't know when to transfer data from framebuffer to panel memory.
> how a driver can know this trigger.
>
> B'coz of this we have only one option left that is always transfer data
> to dif panel from fraembuffer irrespective of any trigger.
>
> This will create power problem.
>
> As i understand microwindows/qt or any graphics package call open, mmap
> from framebuffer. Whenever it draw a line it doesn't call any driver
> interface.
>
> Is there any solution?
> Is there any standard interface of application with driver which tell
> that data is to be updated from frmebuffer to panel memory?

You can try file read and write instead of mmap to access the framebuffer.
Otherwise, you can try trapping all accesses to the memory, but this wil
involve hacking kernel internals.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
