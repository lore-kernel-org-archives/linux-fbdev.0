From: br.shurik@gmail.com
Date: Mon, 24 Oct 2016 12:12:40 +0000
Subject: Re: [PATCH] staging: sm750fb: Fix lock context error
Message-Id: <2875616.l5QEf7t0yO@shurik>
List-Id: <linux-fbdev.vger.kernel.org>
References: <d825266ad9ed386b54656605fe1f805c576ebf42.1477226129.git.br.shurik@gmail.com>
In-Reply-To: <d825266ad9ed386b54656605fe1f805c576ebf42.1477226129.git.br.shurik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Monday, 24 October 2016 13:41:39 IDT Dan Carpenter wrote:
> evaluation
Hi Dan,
Thanks you for your feedback, it kind of felt like workaround.
However, it seems to me like bad design decision took place where locking/
unlocking is dependent on unprotected variable.
From what I could understand from the driver source code the fb_count value 
shouldn't change while in those functions, so the code is safe "as is" and my 
change should only assist with readability. 
So the patch fails to improve readability it is unnecessary.

Best regards,
Alex

