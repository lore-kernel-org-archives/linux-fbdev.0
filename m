From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: mono, gray and index configs
Date: Fri, 12 Aug 2005 18:28:52 +0800
Message-ID: <42FC79E4.2010209@gmail.com>
References: <9e47339105081020216574ac7e@mail.gmail.com> <42FAE3F8.8080902@gmail.com> <Pine.LNX.4.62.0508111020520.1037@numbat.sonytel.be> <b00ca3bd05081104086fa9e639@mail.gmail.com> <Pine.LNX.4.62.0508111344070.1037@numbat.sonytel.be> <42FB8C29.4070503@gmail.com> <Pine.LNX.4.62.0508120923170.18366@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3WnA-0005qT-Gj
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Aug 2005 03:29:36 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E3WnA-0004L2-2W
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Aug 2005 03:29:36 -0700
Received: by wproxy.gmail.com with SMTP id i21so569296wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Aug 2005 03:29:26 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0508120923170.18366@numbat.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@gmail.com>

Geert Uytterhoeven wrote:
> On Fri, 12 Aug 2005, Antonino A. Daplas wrote:
>> Geert Uytterhoeven wrote:
>>> On Thu, 11 Aug 2005, Antonino Daplas wrote:
>>>> (Depending on how correct I am with the interpretation, there might be
>>>> some bugs in fbdev on how it determines the color depth. No one is
>>>> complaining yet though, so greater than 1-bit monochrome is probably
>>>> rare if not nonexistent.)
>>> There definitely are bugs w.r.t. this, especially in the 2.4 logo code ;-)
>>>
>> Yes, I would agree.  Do you know of any outstanding bugs on color handling
>> in 2.6 code, especially for hardware with bitdepths < 8? I would like to
>> fix them.
> 
> Unfortunately not. Due to personel reasons, I temporarily don't have much
> time left to do real coding.
> 
> You can always try vgafb's 16 color mode and check for yourself.

That's okay. I'm actually emulating these low bit depths using pseudocolor whenever
I look for bugs for depths < 4 (ie monochrome text attributes). I haven't found
any yet except for the greater than 1-bit monochrome color handling which I've
already fixed in my tree.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
