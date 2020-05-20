From: Jan Engelhardt <jengelh@inai.de>
Date: Wed, 20 May 2020 10:37:25 +0000
Subject: Re: [RFC PATCH 0/4] DirectX on Linux
Message-Id: <nycvar.YFH.7.77.849.2005201222370.19642@n3.vanv.qr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
 <CAKMK7uGnSDHdZha-=dZN5ns0sJ2CEnK2693uix4tzqyZb9MXCQ@mail.gmail.com>
 <20200519203608.GG33628@sasha-vm>
In-Reply-To: <20200519203608.GG33628@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sasha Levin <sashal@kernel.org>
Cc: linux-hyperv@vger.kernel.org, Olof Johansson <olof.johansson@gmail.com>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>, Greg KH <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "Wilson,
 Chris" <chris@chris-wilson.co.uk>, Jerome Glisse <jglisse@redhat.com>, spronovo@microsoft.com, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jason Ekstrand <jason@jlekstrand.net>, iourit@microsoft.com, Alex Deucher <alexander.deucher@amd.com>, Stephen Hemminger <sthemmin@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Hawking Zhang <Hawking.Zhang@amd.com>


On Tuesday 2020-05-19 22:36, Sasha Levin wrote:
>
>> - Why DX12 on linux? Looking at this feels like classic divide and
>
> There is a single usecase for this: WSL2 developer who wants to run
> machine learning on his GPU. The developer is working on his laptop,
> which is running Windows and that laptop has a single GPU that Windows
> is using.

It does not feel right conceptually. If the target is a Windows API
(DX12/ML), why bother with Linux environments? Make it a Windows executable,
thereby skipping the WSL translation layer and passthrough.
