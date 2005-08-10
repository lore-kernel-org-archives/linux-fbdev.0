From: Andrey Volkov <avolkov@varma-el.com>
Subject: Re: cursor maddnes and a solution
Date: Wed, 10 Aug 2005 20:18:50 +0400
Message-ID: <42FA28EA.4080609@varma-el.com>
References: <Pine.LNX.4.56.0508090115420.2749@pentafluge.infradead.org>	 <42F99B5E.1070309@gmail.com>	 <9e4733910508092358360f8bc8@mail.gmail.com>	 <42F9B1C3.2030201@gmail.com>	 <9e473391050810062531d77aa7@mail.gmail.com>	 <42FA1F55.5010801@varma-el.com> <9e47339105081008517561bfbc@mail.gmail.com> <42FA2652.1060308@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2tIC-0006n8-Cj
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 09:19:00 -0700
Received: from [195.144.244.147] (helo=amanaus.varma-el.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E2tIB-00055t-Tx
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 09:19:00 -0700
In-Reply-To: <42FA2652.1060308@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Antonino A. Daplas wrote:
> Jon Smirl wrote:
> 
>> On 8/10/05, Andrey Volkov <avolkov@varma-el.com> wrote:
>> You are omit hwd cursor size problem - very few (possible no one)
>> graphics chips could support cursor with any size. Usually they support
>> 32x32/64x64 pixels cursors only. For kernel fb its have not meaning,
>> 'cause we always could fallback to the soft_cursor (in the fbcon or
>> directly in a driver), BUT what to do with such crazy user who will wish
>> to use, ex. 100x100 pix cursor in user space?
>>
>>
> 
> If cursor_capabilities() is called, it should return the maximum
> dimensions supported by the hardware. 
> Meaning, we have to change it to:
> 
> int (*cursor_capabilities)(int set, struct fb_cursor_caps *caps);
> 
> so it passes struct fb_cursor_caps *caps instead of int caps.
> 
And max_depth also must present in struct fb_cursor_caps. Why generate
true_color image for monochrome hwd cursor? Conversion from true_color
to monochrome, IMHO, usually very painful.

-- 
Regards
Andrey Volkov


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
