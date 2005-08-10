From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: cursor maddnes and a solution
Date: Thu, 11 Aug 2005 00:07:46 +0800
Message-ID: <42FA2652.1060308@gmail.com>
References: <Pine.LNX.4.56.0508090115420.2749@pentafluge.infradead.org>	 <42F99B5E.1070309@gmail.com>	 <9e4733910508092358360f8bc8@mail.gmail.com>	 <42F9B1C3.2030201@gmail.com>	 <9e473391050810062531d77aa7@mail.gmail.com>	 <42FA1F55.5010801@varma-el.com> <9e47339105081008517561bfbc@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2t82-0006IP-7c
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 09:08:30 -0700
Received: from wproxy.gmail.com ([64.233.184.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E2t80-0002cz-JW
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 09:08:30 -0700
Received: by wproxy.gmail.com with SMTP id i3so157061wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Aug 2005 09:08:19 -0700 (PDT)
In-Reply-To: <9e47339105081008517561bfbc@mail.gmail.com>
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
Cc: Andrey Volkov <avolkov@varma-el.com>, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Jon Smirl wrote:
> On 8/10/05, Andrey Volkov <avolkov@varma-el.com> wrote:
>>
>> Jon Smirl wrote:
>>> On 8/10/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
>>>
>>>> struct fb_cursor_ops {
>>>>        int (*cursor_move)(int x, int y);
>>>>        int (*cursor_show)(int show);
>>>>        int (*cursor_load_image)(u32 *image, int width, int height);
>>>>        int (*cursor_load_color)(struct fb_cmap *cmap);
>>>>        int (*cursor_set_size)(int width, int height);
>>>>        int (*cursor_capabilities)(int set, int caps);
>>>> };
>>>
>>> Doen't fb already support an image format with embedded color map? Can
>>> we use it and merge:
>>>
>>>>        int (*cursor_load_image)(u32 *image, int width, int height);
>>>>        int (*cursor_load_color)(struct fb_cmap *cmap);

Yes, we can do that.
 
>>>
>>> The size can also be computed from the image so the size call can be eliminated.
>>>
>> You are omit hwd cursor size problem - very few (possible no one)
>> graphics chips could support cursor with any size. Usually they support
>> 32x32/64x64 pixels cursors only. For kernel fb its have not meaning,
>> 'cause we always could fallback to the soft_cursor (in the fbcon or
>> directly in a driver), BUT what to do with such crazy user who will wish
>> to use, ex. 100x100 pix cursor in user space?
> 

If cursor_capabilities() is called, it should return the maximum
dimensions supported by the hardware.  

Meaning, we have to change it to:

int (*cursor_capabilities)(int set, struct fb_cursor_caps *caps);

so it passes struct fb_cursor_caps *caps instead of int caps.

Of course, if user is so crazy that he/she insists on using a 100x100 cursor
image, the kernel should return an error and, as Jon said, fallback to
a software implementation

Tony 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
