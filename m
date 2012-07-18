From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 18 Jul 2012 22:57:47 +0000
Subject: Re: [PATCH] fbdev: Add ioctls FBIO_COPYRECT, FBIO_FILLRECT, lest these operations be done in softwar
Message-Id: <2444839.KFfsli056l@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAL3m8eA=46wdwVosiE54eNx3FOuLyxfE5axKs_HjyMTGxDHRDw@mail.gmail.com>
In-Reply-To: <CAL3m8eA=46wdwVosiE54eNx3FOuLyxfE5axKs_HjyMTGxDHRDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Strake <strake888@gmail.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 21 June 2012 07:22:50 Strake wrote:
> From: Matthew Farkas-Dyck <strake888@gmail.com>
> 
> Add ioctls FBIO_COPYRECT, FBIO_FILLRECT, lest these operations be done
> in software.
> 
> Signed-off-by: Matthew Farkas-Dyck <strake888@gmail.com>
> ---
> 
> Reason: If it can be done in hardware, it ought to be. This will
> enable user-mode software to do so.

If we really want to go this way, I think we should develop a proper 2D 
acceleration API. I'm not sure whether it's worth the effort though.

-- 
Regards,

Laurent Pinchart

