From: Ladislav Michl <ladis@linux-mips.org>
Date: Wed, 29 Nov 2017 16:18:58 +0000
Subject: Re: omapfb: dss: Do not duplicate features data
Message-Id: <20171129161858.GB30740@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <14688566-4b07-6167-914c-545948ace611@users.sourceforge.net>
In-Reply-To: <14688566-4b07-6167-914c-545948ace611@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Wed, Nov 29, 2017 at 03:38:46PM +0100, SF Markus Elfring wrote:
> > As features data are read only, there is no need to allocate their
> > copy on the heap.
> …
> >  Note2: Marcus, I hope it is okay to add your Suggested-by tag.
> 
> Maybe.
> 
> >         Please let me know, if I'm wrong.
> 
> I am unsure about the view on how much I suggested such a source code adjustment.

Well, it is up to you completely. I didn't find any more relevant tag, which
neccessarily doesn't mean it is appropriate.

> A development discussion for my update suggestion “omapfb/dss: Delete an error message
> for a failed memory allocation in three functions” triggered the contribution of your idea.

I would never look at that code without looking to said patch.

> https://lkml.org/lkml/2017/11/27/919
> 
> Did you omit the general Linux kernel mailing list from your proposal intentionally?

I've never sent single mail to the general Linux kernel mailing list other than
it already was in Cc. It was write-only list decade ago and now it is not any
better :)

Best regards,
	ladis
