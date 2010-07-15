From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Thu, 15 Jul 2010 19:23:15 +0000
Subject: Re: [PATCH v2] s3c-fb: Automatically calculate pixel clock when none
Message-Id: <4C3F6023.5080002@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4c3baddb.d37b0e0a.67e4.ffffcb55@mx.google.com> <20100715115238.6c90b90a.akpm@linux-foundation.org>
In-Reply-To: <20100715115238.6c90b90a.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org

 Op 15-07-10 20:52, Andrew Morton schreef:
> On Tue, 13 Jul 2010 02:05:45 +0200
> Maurus Cuelenaere <mcuelenaere@gmail.com> wrote:
>
>> This patch adds a simple algorithm which calculates the pixel clock based on the
>> video mode parameters. This is only done when no pixel clock is supplied through
>> the platform data.
>>
> So..  we are to assume that there's a platform which doesn't provide
> the pixel clock data?  Adding some information about that in the
> changelog would have been useful.

Not exactly, this allows you to omit the pixel clock data and thus sharing the
"algo" used for calculating it; which is done in another patch (not submitted to
linux-fbdev, see [1]).

[1] - http://www.spinics.net/lists/linux-samsung-soc/msg02086.html

-- 
Maurus Cuelenaere
