From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: i810fb fails to load
Date: Tue, 23 Jan 2007 08:50:39 +1100
Message-ID: <21d7e9970701221350h3a8959faqcd099bf4e0a761fa@mail.gmail.com>
References: <20070111222627.66bb75ab.akpm@osdl.org> <45AAC244.8060607@imap.cc>
	 <20070114162235.4c8d241f.akpm@osdl.org>
	 <45B4BF50.9010105@tungstengraphics.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751862AbXAVVum@vger.kernel.org>
In-Reply-To: <45B4BF50.9010105@tungstengraphics.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
Cc: Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Dave Airlie <airlied@linux.ie>

> >>
> >>
> >
> > Don't know.  But I bet someone on the Cc does...
> >
> Tilman,
> Thanks for reporting.
> Can you try the attached patch to see if that fixes the problem.
>

Hi Thomas,

This also fixes X starting on old i810/5 hardware, I had noticed it
broken but hadn't had time to investigate it, this patch fixes it...

Dave.
