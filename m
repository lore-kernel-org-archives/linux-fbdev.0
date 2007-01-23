From: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
Subject: Re: i810fb fails to load
Date: Tue, 23 Jan 2007 09:10:37 +0100
Message-ID: <45B5C2FD.6090100@tungstengraphics.com>
References: <20070111222627.66bb75ab.akpm@osdl.org> <45AAC244.8060607@imap.cc>	
	<20070114162235.4c8d241f.akpm@osdl.org>	
	<45B4BF50.9010105@tungstengraphics.com>
	<21d7e9970701221350h3a8959faqcd099bf4e0a761fa@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H9GkQ-0000qc-Pb for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 00:11:18 -0800
Received: from ns2.gothnet.se ([82.193.160.251] helo=GOTHNET-SMTP2.gothnet.se)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H9GkO-0000RA-SB
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 00:11:18 -0800
In-Reply-To: <21d7e9970701221350h3a8959faqcd099bf4e0a761fa@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Dave Airlie <airlied@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Dave Airlie <airlied@linux.ie>, Tilman Schmidt <tilman@imap.cc>, linux-kernel@vger.kernel.org

Dave Airlie wrote:
>> >>
>> >>
>> >
>> > Don't know.  But I bet someone on the Cc does...
>> >
>> Tilman,
>> Thanks for reporting.
>> Can you try the attached patch to see if that fixes the problem.
>>
>
> Hi Thomas,
>
> This also fixes X starting on old i810/5 hardware, I had noticed it
> broken but hadn't had time to investigate it, this patch fixes it...
>
> Dave.
Great.
The oldest hardware I have is an i915 which hampers me a bit.

/Thomas




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
