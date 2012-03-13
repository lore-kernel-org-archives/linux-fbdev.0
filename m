From: Anatolij Gustschin <agust@denx.de>
Date: Tue, 13 Mar 2012 09:42:55 +0000
Subject: Re: [PATCH 1/2] fbdev: da8xx:: fix reporting of the display timing info
Message-Id: <20120313104255.718ace1e@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331305336-32644-2-git-send-email-agust@denx.de>
In-Reply-To: <1331305336-32644-2-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On Mon, 12 Mar 2012 05:19:54 +0000
"Manjunathappa, Prakash" <prakash.pm@ti.com> wrote:
...
> > +static inline unsigned long hz_to_ps(unsigned long hz_val)
> > +{
> > +	unsigned long long num = 1000000000000ULL;
> > +
> > +	do_div(num, hz_val);
> > +	return (unsigned long)num;
> > +}
> > +
> 
> I have patch to take care of this:
> 
> http://davinci-linux-open-source.1494791.n2.nabble.com/PATCH-v2-video-da8xx-fb-calculate-pixel-clock-period-for-the-panel-tt7268377.html#none

Okay, thanks for the info! I'll rebase my patches and then resubmit.

Thanks,
Anatolij
