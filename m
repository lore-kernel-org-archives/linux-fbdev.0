From: Hans Verkuil <hansverk@cisco.com>
Date: Mon, 02 May 2011 13:20:22 +0000
Subject: Re: Query: Implementation of overlay on linux
Message-Id: <201105021520.22842.hansverk@cisco.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4DBE8FDB.5010506@st.com>
In-Reply-To: <4DBE8FDB.5010506@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vipul kumar samar <vipulkumar.samar@st.com>
Cc: linux-media@vger.kernel.org, linux-fbdev@vger.kernel.org

On Monday, May 02, 2011 13:04:59 vipul kumar samar wrote:
> Hello,
> 
> I am working on LCD module and I want to implement two overlay windows
> on frame buffer. I have some queries related to this:

You mean capture overlay windows? E.g. you want to capture from a video input 
and have the video directly rendered in the framebuffer?

The "Video Overlay Interface" section in the V4L2 specification describes how 
to do that, but it also depends on whether the V4L2 driver in question 
supports that feature.

It might be that you mean something else, though.

Regards,

	Hans

> 1. Can any body suggest me how to proceed towards it??
> 2. Is their any standard way to use frame buffer ioctl calls??
> 3. If i have to define my own ioctls then how application manage it??
> 
> 
> Thanks and Regards
> Vipul Samar
> --
> To unsubscribe from this list: send the line "unsubscribe linux-media" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
