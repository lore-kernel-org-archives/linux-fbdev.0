From: Scot Doyle <lkml14@scotdoyle.com>
Date: Tue, 21 Jul 2015 18:45:34 +0000
Subject: Re: [PATCH v2 3/3] console_codes.4: Add CSI sequence for cursor blink interval
Message-Id: <alpine.DEB.2.11.1507211827520.3781@local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.11.1501262034380.1945@localhost.localdomain> <alpine.DEB.2.11.1501262040380.2052@localhost.localdomain> <20150225094946.GA24627@amd> <alpine.LNX.2.11.1502252319330.276@localhost> <20150226220243.GC9935@amd> <alpine.LNX.2.11.1502271905580.4212@localhost>
 <alpine.LNX.2.11.1502271911380.4248@localhost> <20150325111949.GA24230@kroah.com> <alpine.DEB.2.11.1503261341260.2164@local> <alpine.DEB.2.11.1503261356490.2411@local> <alpine.DEB.2.11.1507051724240.1696@local>
 <CAKgNAkgqTckfydFTDFsoqB1b_fAEiDZGYP=7b-bhN8d4Mp-bsg@mail.gmail.com>
In-Reply-To: <CAKgNAkgqTckfydFTDFsoqB1b_fAEiDZGYP=7b-bhN8d4Mp-bsg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-man <linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>

On Tue, 21 Jul 2015, Michael Kerrisk (man-pages) wrote:
> On 5 July 2015 at 19:41, Scot Doyle <lkml14@scotdoyle.com> wrote:
> > On Thu, 26 Mar 2015, Scot Doyle wrote:
> >> Add a Console Private CSI sequence to specify the current console's
> >> cursor blink interval. The interval is specified as a number of
> >> milliseconds until the next cursor display state toggle, from 50 to
> >> 65535.
> >>
> >> Signed-off-by: Scot Doyle <lkml14@scotdoyle.com>
> 
> I've applied this, adding Pavel's Acked-by.
> 
> I also added some text to note that this appeared in Linux 4.2. Okay?

Yes, thank you.

