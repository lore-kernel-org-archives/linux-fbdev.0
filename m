From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 12 Dec 2011 18:49:38 +0000
Subject: Re: [PATCH v4 0/3] fbdev: Add FOURCC-based format configuration API
Message-Id: <4EE64CC2.5090906@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1322562419-9934-1-git-send-email-laurent.pinchart@ideasonboard.com> <201112121708.30839.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201112121708.30839.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org

Hi Laurent,

On 12/12/2011 04:08 PM, Laurent Pinchart wrote:
> Hi Florian,
> 
> On Tuesday 29 November 2011 11:26:56 Laurent Pinchart wrote:
>> Hi everybody,
>>
>> Here's the fourth version of the fbdev FOURCC-based format configuration
>> API.
> 
> Is there a chance this will make it to v3.3 ?

Yes, that's likely. I thought you wanted to post a new version of 2/3?
I think you also want to do something with red, green, blue, transp when
entering FOURCC mode, at least setting them to zero or maybe even requiring that
they are zero to enter FOURCC mode (as additional safety barrier).


Best regards,

Florian Tobias Schandinat
