From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] - video/tdfxfb.c warning fix.
Date: Fri, 30 Apr 2004 21:35:13 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040430213513.7bafde36.akpm@osdl.org>
References: <20040430180451.GA3119@lorien.prodam>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJmE1-0007G1-LH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 21:35:41 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJmDz-0003on-Og
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Apr 2004 21:35:39 -0700
In-Reply-To: <20040430180451.GA3119@lorien.prodam>
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
To: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Cc: jsimmons@infraded.org, linux-fbdev-devel@lists.sourceforge.net

"Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br> wrote:
>
>  This patch fixes this warning:
> 
>   drivers/video/tdfxfb.c:1005: warning: `tdfxfb_cursor' defined but not
>   used
> 
>   and make the acceleration function selectable (like hgafb
>  and tridentfb):
> 

You've taken a bunch of previously-working 3d acceleration functions and
made them configurable, dependent upon CONFIG_EXPERIMENTAL.

What on earth for?  Will this not gratuitously break people's
previously-working 3d setups?



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
