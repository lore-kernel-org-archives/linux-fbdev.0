From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: frame bufffer on CRT
Date: Mon, 15 Nov 2004 18:57:43 +0800
Message-ID: <200411151857.44175.adaplas@hotpop.com>
References: <419860AE.4000606@ncoretech.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CTeYh-0005yW-S1
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Nov 2004 02:58:07 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CTeYg-00081P-Tm
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Nov 2004 02:58:07 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id B79219C84ED
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Nov 2004 10:57:45 +0000 (UTC)
In-Reply-To: <419860AE.4000606@ncoretech.com>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, ramprasad <ramprasad@ncoretech.com>

On Monday 15 November 2004 15:54, ramprasad wrote:
> Hi All,
>         I am using 2.4.19-rmk7-pxa1  kernel on my PXA-255 board which is
> using epson13506 chip for  CRT display.
> I am seeing the linux logo on my CRT.The problem is, i am seeing two
> linux logo on my CRT.
> i have set my  display to 640x480. Can anybody explain why i am seeing
> this.
>

The number of logos you see is equal to the number of CPU's in your system.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
