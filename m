From: Romain Dolbeau <dolbeau@irisa.fr>
Subject: Re: pm3fb driver is ok in 2.5.24
Date: Tue, 06 Aug 2002 11:59:48 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3D4F9E14.9B7E9C2D@irisa.fr>
References: <Pine.LNX.4.44.0207041939510.1718-100000@www.transvirtual.com> 
			<3D2559A3.F13D413F@irisa.fr> <1028466027.6487.3613.camel@tibook> 
			<3D4E5EA2.4290840F@irisa.fr> <1028546549.1112.842.camel@tibook> <3D4F8F65.11D3AA09@irisa.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sky.irisa.fr ([131.254.60.147])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17c18Z-0004W4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 06 Aug 2002 03:00:24 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Romain Dolbeau <Romain.Dolbeau@irisa.fr>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, linux-fbdev-devel@lists.sourceforge.net

Romain Dolbeau wrote:

> Thanks, but this doesn't help: beside the not really
> needed serial ports and floppy drive, the SCSI
> drivers also don't compile. And this box has no
> IDE channel.

Good news: Only 53c94 doesn't compile, but MESH is OK,
           and linux is on the internal bus (w/ MESH)

Bad news: arch/ppc/kernel/process.c doesn't compile.

So the conlusion stand: 2.4.x only for my box ATM

-- 
DOLBEAU Romain           | I witness a time and a place that never dies,
ENS Cachan / Ker Lann    | still frozen in time, this darkness the only 
Thesard IRISA / CAPS     | place that I can hide. I witness, a dream.   
dolbeaur@club-internet.fr|  -- Black Sabbath, 'I Witness'


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
