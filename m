From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: cursor maddnes and a solution
Date: Thu, 11 Aug 2005 00:33:58 +0800
Message-ID: <42FA2C76.6040700@gmail.com>
References: <Pine.LNX.4.56.0508090115420.2749@pentafluge.infradead.org>	 <42F99B5E.1070309@gmail.com>	 <9e4733910508092358360f8bc8@mail.gmail.com>	 <42F9B1C3.2030201@gmail.com>	 <9e473391050810062531d77aa7@mail.gmail.com>	 <42FA1F55.5010801@varma-el.com> <9e47339105081008517561bfbc@mail.gmail.com> <42FA2652.1060308@gmail.com> <42FA28EA.4080609@varma-el.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2tXJ-0007cq-I2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 09:34:37 -0700
Received: from wproxy.gmail.com ([64.233.184.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E2tXI-0007hA-AW
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 09:34:37 -0700
Received: by wproxy.gmail.com with SMTP id i3so162883wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Aug 2005 09:34:27 -0700 (PDT)
In-Reply-To: <42FA28EA.4080609@varma-el.com>
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
To: Andrey Volkov <avolkov@varma-el.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Andrey Volkov wrote:
> Antonino A. Daplas wrote:
>> Jon Smirl wrote:
>>
>>
> And max_depth also must present in struct fb_cursor_caps. Why generate

Yes.

> true_color image for monochrome hwd cursor? Conversion from true_color
> to monochrome, IMHO, usually very painful.

That was just a proposal. Another way, as Jon proposed, is to combine the
image with struct fb_cmap. This is similar to how the penguin logo is
encoded. 

Tony



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
