From: James Simmons <jsimmons@infradead.org>
Date: Wed, 10 Mar 2010 16:41:40 +0000
Subject: Re: [PATCH] s3c2410fb: silence warning
Message-Id: <alpine.LFD.2.00.1003101641170.4419@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <876356o0ct.fsf@lechat.rtp-net.org>
In-Reply-To: <876356o0ct.fsf@lechat.rtp-net.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-fbdev@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-samsung-soc@vger.kernel.org


Can you please resend it not as a attachemnt. Thank you.


> 
> 
> When building s3c2410fb with CPU_FREQ set, one gets :
> 
> drivers/video/s3c2410fb.c: In function 's3c2410fb_cpufreq_transition':
> drivers/video/s3c2410fb.c:769: warning: unused variable 'freqs'
> 
> Remove this useless declaration to silence the warning.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> ---
> 
