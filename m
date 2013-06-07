From: Alex Courbot <acourbot@nvidia.com>
Date: Fri, 07 Jun 2013 07:28:29 +0000
Subject: Re: [PATCH v2] simplefb: add support for a8b8g8r8 pixel format
Message-Id: <51B18B9D.1030901@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1370584869-2904-1-git-send-email-acourbot@nvidia.com> <1370589753.21409.140661241005617.2A5614D3@webmail.messagingengine.com>
In-Reply-To: <1370589753.21409.140661241005617.2A5614D3@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander van Heukelum <heukelum@fastmail.fm>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Olof Johansson <olof@lixom.net>, "gnurou@gmail.com" <gnurou@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On 06/07/2013 04:22 PM, Alexander van Heukelum wrote:
>>   static struct simplefb_format simplefb_formats[] = {
>>   	{ "r5g6b5", 16, {11, 5}, {5, 6}, {0, 5}, {0, 0} },
>> +	{ "a8b8g8r8", 32, {0, 8}, {8, 8}, {16, 8}, {31, 8} },
>
> Hi,
>
> 31? I assume in practice this doesn't influence anything, but I think it should have read 24.

Doh. Thanks for pointing it out.

Alex.

