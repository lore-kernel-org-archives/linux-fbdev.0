From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: Re: FBDEV 2.6.0-test7 updates.
Date: Thu, 16 Oct 2003 11:29:06 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031016092906.GA6602@iliana>
References: <20031015162056.018737f1.akpm@osdl.org> <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org> <20031016091918.GA1002@casa.fluido.as>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AA4Ry-0006qc-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 02:29:42 -0700
Received: from smtp4.wanadoo.fr ([193.252.22.27] helo=mwinf0401.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AA4Rw-0006i9-27
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Oct 2003 02:29:40 -0700
Content-Disposition: inline
In-Reply-To: <20031016091918.GA1002@casa.fluido.as>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 11:19:18AM +0200, Carlo E. Prelz wrote:
>  /* Radeon RV280 (9200) */
>  #define PCI_DEVICE_ID_ATI_RADEON_Y_    0x5960
> +#define PCI_DEVICE_ID_ATI_RADEON_Yz    0x5964
>  /* Radeon R300 (9500) */
>  #define PCI_DEVICE_ID_ATI_RADEON_AD    0x4144
>  /* Radeon R300 (9700) */
> 
> (I did not know how to call it. _Yz did not exist, so I grabbed it. Is
> there any logic in these codes?)

You use the ascii code of the id :

  0x41 -> A, 0x44 -> D thus 0x4144 -> AD.

So, the 0x5964 must be Yd.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
