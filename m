From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: CRTC scanout buffer types
Date: Mon, 08 Aug 2005 13:52:07 +0800
Message-ID: <42F6F307.9000504@gmail.com>
References: <9e47339105080513195dee0804@mail.gmail.com>	 <Pine.LNX.4.62.0508071135450.31010@gorilla.sonytel.be>	 <9e47339105080706414faf1e40@mail.gmail.com>	 <42F67719.9050805@us.ibm.com> <42F68105.1080207@pol.net>	 <Pine.LNX.4.62.0508071830270.11306@node2.an-vo.com>	 <42F6B21E.1070405@gmail.com> <9e47339105080719338b78aa@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2139-0002jY-9U
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 23:23:51 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E2138-0001FN-OS
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 23:23:51 -0700
Received: by wproxy.gmail.com with SMTP id i8so934697wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 23:23:44 -0700 (PDT)
In-Reply-To: <9e47339105080719338b78aa@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Vladimir Dergachev <volodya@mindspring.com>, Ian Romanick <idr@us.ibm.com>, linux-fbdev-devel@lists.sourceforge.net, DRI developer's list <dri-devel@lists.sourceforge.net>

Jon Smirl wrote:
> On 8/7/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Vladimir Dergachev wrote:
>>>> I agree that something like the above is acceptable, exept that we need
>>>> an extra field for offset and another if indexed color or not. So
>>>> something like:
>>>>
>>>> A:2/0/R:10/2/G:10/12/B:10/22//I
> 
> The offsets are not needed as part of the input, they should be part
> of the output display. It is the chip driver that will determine the
> offsets, not the user.
> 

Without the offsets, how will it differentiate ARGB2222/8bpp vs ARGB2/8bpp?

Tony




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
