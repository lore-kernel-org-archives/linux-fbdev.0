From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: FBDEV 2.6.0-test7 updates.
Date: Fri, 17 Oct 2003 17:48:02 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310171747230.966-100000@phoenix.infradead.org>
References: <20031016092906.GA6602@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAXlz-0002HO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 09:48:20 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1AAXlr-00046u-43
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Oct 2003 09:48:11 -0700
In-Reply-To: <20031016092906.GA6602@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: "Carlo E. Prelz" <fluido@fluido.as>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


> On Thu, Oct 16, 2003 at 11:19:18AM +0200, Carlo E. Prelz wrote:
> >  /* Radeon RV280 (9200) */
> >  #define PCI_DEVICE_ID_ATI_RADEON_Y_    0x5960
> > +#define PCI_DEVICE_ID_ATI_RADEON_Yz    0x5964
> >  /* Radeon R300 (9500) */
> >  #define PCI_DEVICE_ID_ATI_RADEON_AD    0x4144
> >  /* Radeon R300 (9700) */
> > 
> > (I did not know how to call it. _Yz did not exist, so I grabbed it. Is
> > there any logic in these codes?)
> 
> You use the ascii code of the id :
> 
>   0x41 -> A, 0x44 -> D thus 0x4144 -> AD.
> 
> So, the 0x5964 must be Yd.

So that is the logic to it?




-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
