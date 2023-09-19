Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD91CD5BBD
	for <linux-fbdev@archiver.kernel.org>; Tue, 19 Sep 2023 13:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjISNt4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 19 Sep 2023 09:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjISNtz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 19 Sep 2023 09:49:55 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9187083
        for <linux-fbdev@vger.kernel.org>; Tue, 19 Sep 2023 06:49:47 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 094EB61E5FE01;
        Tue, 19 Sep 2023 15:49:40 +0200 (CEST)
Message-ID: <66e80853-722d-4d79-b624-a1b52e9c1370@molgen.mpg.de>
Date:   Tue, 19 Sep 2023 15:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: simpledrm instead of efifb used on Nvidia system
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Peter Jones <pjones@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, it+linux-fbdev@molgen.mpg.de
References: <fbf99fb6-18ad-429e-88c0-a6af580386c8@molgen.mpg.de>
In-Reply-To: <fbf99fb6-18ad-429e-88c0-a6af580386c8@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

[First message bounced due to size of attached logs/config.]

Dear Linux folks,


Am 19.09.23 um 13:58 schrieb Paul Menzel:

> On a Dell Precision 7920 Tower moving from Linux 5.15.112 to 5.15.131 
> and converting to DRM simple frame buffer [1] and keeping FB_EFI 
> selected, efifb is not used and not even lightdm shows up on the monitor.
> 
>      $ lspci -nn -s b3:
>      b3:00.0 VGA compatible controller [0300]: NVIDIA Corporation GA104GL [RTX A4000] [10de:24b0] (rev a1)
>      b3:00.1 Audio device [0403]: NVIDIA Corporation GA104 High Definition Audio Controller [10de:228b] (rev a1)
> 
> ### Linux 5.15.112
> 
> ```
> [    0.000000] microcode: microcode updated early to revision 0x5003604, date = 2023-03-17
> [    0.000000] Linux version 5.15.112.mx64.449 (root@theinternet.molgen.mpg.de) (gcc (GCC) 10.4.0, GNU ld (GNU Binutils) 2.40) #1 SMP Tue May 23 12:51:43 CEST 2023
> […]
> [    0.000000] DMI: Dell Inc. Precision 7920 Tower/060K5C, BIOS 2.14.0 07/27/2021
> […]
> [   21.427175] pci 0000:b3:00.0: BAR 1: assigned to efifb
> […]
> [   23.691629] intel_pstate: HWP enabled
> [   23.695292] efifb: probing for efifb
> [   23.698869] efifb: framebuffer at 0xe0000000, using 8128k, total 8128k
> [   23.705370] efifb: mode is 1920x1080x32, linelength=7680, pages=1
> [   23.711437] efifb: scrolling: redraw
> [   23.714996] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [   23.725738] Console: switching to colour frame buffer device 240x67
> [   23.737117] fb0: EFI VGA frame buffer device
> [   23.741388] EFI Variables Facility v0.08 2004-May-17
> [   23.751907] sr 0:0:0:0: [sr0] scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
> [   23.759673] cdrom: Uniform CD-ROM driver Revision: 3.20
> […]
> ```
> 
> ### Linux 5.15.131
> 
> ```
> [    0.000000] microcode: microcode updated early to revision 0x5003604, date = 2023-03-17
> [    0.000000] Linux version 5.15.131.mx64.457 (root@invidia.molgen.mpg.de) (gcc (GCC) 10.4.0, GNU ld (GNU Binutils) 2.41) #1 SMP Tue Sep 12 12:55:20 CEST 2023
> […]
> [    0.000000] DMI: Dell Inc. Precision 7920 Tower/060K5C, BIOS 2.14.0 07/27/2021
> […]
> [   20.807497] pci 0000:b3:00.0: BAR 1: assigned to efifb
> […]
> [   23.005548] intel_pstate: HWP enabled
> [   23.009322] [drm] Initialized simpledrm 1.0.0 20200625 for simple-framebuffer.0 on minor 0
> [   23.019561] simple-framebuffer simple-framebuffer.0: [drm] drm_plane_enable_fb_damage_clips() not called
> [   23.027172] Console: switching to colour frame buffer device 240x67
> [   23.041623] sr 0:0:0:0: [sr0] scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
> [   23.046490] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
> [   23.069016] cdrom: Uniform CD-ROM driver Revision: 3.20
> [   23.074262] EFI Variables Facility v0.08 2004-May-17
> […]
> ```
> 
> ### Configuration differences
> 
> ```
> $ diff -u config-5.15.1* # [2][3]
> --- config-5.15.112.mx64.449    2023-05-23 13:02:05.000000000 +0200
> +++ config-5.15.131.mx64.457    2023-09-12 13:14:42.000000000 +0200
> @@ -1,15 +1,15 @@
>   #
>   # Automatically generated file; DO NOT EDIT.
> -# Linux/x86 5.15.112 Kernel Configuration
> +# Linux/x86 5.15.131 Kernel Configuration
>   #
>   CONFIG_CC_VERSION_TEXT="gcc (GCC) 10.4.0"
>   CONFIG_CC_IS_GCC=y
>   CONFIG_GCC_VERSION=100400
>   CONFIG_CLANG_VERSION=0
>   CONFIG_AS_IS_GNU=y
> -CONFIG_AS_VERSION=24000
> +CONFIG_AS_VERSION=24100
>   CONFIG_LD_IS_BFD=y
> -CONFIG_LD_VERSION=24000
> +CONFIG_LD_VERSION=24100
>   CONFIG_LLD_VERSION=0
>   CONFIG_CC_CAN_LINK=y
>   CONFIG_CC_CAN_LINK_STATIC=y
> @@ -27,7 +27,7 @@
>   CONFIG_INIT_ENV_ARG_LIMIT=32
>   # CONFIG_COMPILE_TEST is not set
>   # CONFIG_WERROR is not set
> -CONFIG_LOCALVERSION=".mx64.449"
> +CONFIG_LOCALVERSION=".mx64.457"
>   CONFIG_LOCALVERSION_AUTO=y
>   CONFIG_BUILD_SALT=""
>   CONFIG_HAVE_KERNEL_GZIP=y
> @@ -394,7 +394,7 @@
>   CONFIG_MICROCODE=y
>   CONFIG_MICROCODE_INTEL=y
>   CONFIG_MICROCODE_AMD=y
> -# CONFIG_MICROCODE_LATE_LOADING is not set
> +CONFIG_MICROCODE_LATE_LOADING=y
>   CONFIG_X86_MSR=m
>   CONFIG_X86_CPUID=m
>   CONFIG_X86_5LEVEL=y
> @@ -466,6 +466,8 @@
>   CONFIG_CPU_UNRET_ENTRY=y
>   CONFIG_CPU_IBPB_ENTRY=y
>   CONFIG_CPU_IBRS_ENTRY=y
> +CONFIG_CPU_SRSO=y
> +# CONFIG_GDS_FORCE_MITIGATION is not set
>   CONFIG_ARCH_HAS_ADD_PAGES=y
>   CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
>   CONFIG_USE_PERCPU_NUMA_NODE_ID=y
> @@ -661,6 +663,7 @@
>   CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
>   CONFIG_ARCH_HAS_SET_MEMORY=y
>   CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> +CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
>   CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
>   CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
>   CONFIG_ARCH_WANTS_NO_INSTR=y
> @@ -1467,7 +1470,6 @@
>   CONFIG_VLAN_8021Q=m
>   CONFIG_VLAN_8021Q_GVRP=y
>   CONFIG_VLAN_8021Q_MVRP=y
> -# CONFIG_DECNET is not set
>   CONFIG_LLC=m
>   # CONFIG_LLC2 is not set
>   # CONFIG_ATALK is not set
> @@ -1807,13 +1809,12 @@
>   # CONFIG_ISCSI_IBFT is not set
>   # CONFIG_FW_CFG_SYSFS is not set
>   CONFIG_SYSFB=y
> -# CONFIG_SYSFB_SIMPLEFB is not set
> +CONFIG_SYSFB_SIMPLEFB=y
>   CONFIG_GOOGLE_FIRMWARE=y
>   # CONFIG_GOOGLE_SMI is not set
>   CONFIG_GOOGLE_COREBOOT_TABLE=m
>   CONFIG_GOOGLE_MEMCONSOLE=m
>   # CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
> -# CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT is not set
>   CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=m
>   # CONFIG_GOOGLE_VPD is not set
> 
> @@ -1874,7 +1875,6 @@
>   CONFIG_BLK_DEV_DRBD=y
>   # CONFIG_DRBD_FAULT_INJECTION is not set
>   CONFIG_BLK_DEV_NBD=m
> -# CONFIG_BLK_DEV_SX8 is not set
>   CONFIG_BLK_DEV_RAM=y
>   CONFIG_BLK_DEV_RAM_COUNT=16
>   CONFIG_BLK_DEV_RAM_SIZE=4096
> @@ -2865,7 +2865,7 @@
> 
>   CONFIG_I2C_HELPER_AUTO=y
>   CONFIG_I2C_SMBUS=y
> -CONFIG_I2C_ALGOBIT=m
> +CONFIG_I2C_ALGOBIT=y
> 
>   #
>   # I2C Hardware Bus support
> @@ -3625,11 +3625,12 @@
>   CONFIG_VGA_ARB=y
>   CONFIG_VGA_ARB_MAX_GPUS=16
>   # CONFIG_VGA_SWITCHEROO is not set
> -CONFIG_DRM=m
> +CONFIG_DRM=y
>   CONFIG_DRM_MIPI_DSI=y
>   # CONFIG_DRM_DP_AUX_CHARDEV is not set
> +# CONFIG_DRM_DEBUG_MM is not set
>   # CONFIG_DRM_DEBUG_SELFTEST is not set
> -CONFIG_DRM_KMS_HELPER=m
> +CONFIG_DRM_KMS_HELPER=y
>   CONFIG_DRM_FBDEV_EMULATION=y
>   CONFIG_DRM_FBDEV_OVERALLOC=100
>   # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
> @@ -3728,7 +3729,7 @@
>   CONFIG_DRM_BOCHS=m
>   CONFIG_DRM_CIRRUS_QEMU=m
>   # CONFIG_DRM_GM12U320 is not set
> -# CONFIG_DRM_SIMPLEDRM is not set
> +CONFIG_DRM_SIMPLEDRM=y
>   # CONFIG_DRM_VBOXVIDEO is not set
>   # CONFIG_DRM_GUD is not set
>   CONFIG_DRM_LEGACY=y
> @@ -3748,32 +3749,28 @@
>   CONFIG_FB_NOTIFY=y
>   CONFIG_FB=y
>   # CONFIG_FIRMWARE_EDID is not set
> -CONFIG_FB_DDC=m
>   CONFIG_FB_CFB_FILLRECT=y
>   CONFIG_FB_CFB_COPYAREA=y
>   CONFIG_FB_CFB_IMAGEBLIT=y
> -CONFIG_FB_SYS_FILLRECT=m
> -CONFIG_FB_SYS_COPYAREA=m
> -CONFIG_FB_SYS_IMAGEBLIT=m
> +CONFIG_FB_SYS_FILLRECT=y
> +CONFIG_FB_SYS_COPYAREA=y
> +CONFIG_FB_SYS_IMAGEBLIT=y
>   # CONFIG_FB_FOREIGN_ENDIAN is not set
> -CONFIG_FB_SYS_FOPS=m
> +CONFIG_FB_SYS_FOPS=y
>   CONFIG_FB_DEFERRED_IO=y
> -CONFIG_FB_BACKLIGHT=m
> -CONFIG_FB_MODE_HELPERS=y
> +# CONFIG_FB_MODE_HELPERS is not set
>   # CONFIG_FB_TILEBLITTING is not set
> 
>   #
>   # Frame buffer hardware drivers
>   #
> -CONFIG_FB_CIRRUS=m
> -CONFIG_FB_PM2=m
> -# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
> -CONFIG_FB_CYBER2000=m
> -CONFIG_FB_CYBER2000_DDC=y
> -CONFIG_FB_ARC=m
> +# CONFIG_FB_CIRRUS is not set
> +# CONFIG_FB_PM2 is not set
> +# CONFIG_FB_CYBER2000 is not set
> +# CONFIG_FB_ARC is not set
>   # CONFIG_FB_ASILIANT is not set
>   # CONFIG_FB_IMSTT is not set
> -CONFIG_FB_VGA16=m
> +# CONFIG_FB_VGA16 is not set
>   # CONFIG_FB_UVESA is not set
>   # CONFIG_FB_VESA is not set
>   CONFIG_FB_EFI=y
> @@ -3781,19 +3778,12 @@
>   # CONFIG_FB_HGA is not set
>   # CONFIG_FB_OPENCORES is not set
>   # CONFIG_FB_S1D13XXX is not set
> -CONFIG_FB_NVIDIA=m
> -CONFIG_FB_NVIDIA_I2C=y
> -CONFIG_FB_NVIDIA_DEBUG=y
> -CONFIG_FB_NVIDIA_BACKLIGHT=y
> +# CONFIG_FB_NVIDIA is not set
>   # CONFIG_FB_RIVA is not set
> -CONFIG_FB_I740=m
> -CONFIG_FB_LE80578=m
> -CONFIG_FB_CARILLO_RANCH=m
> +# CONFIG_FB_I740 is not set
> +# CONFIG_FB_LE80578 is not set
>   # CONFIG_FB_MATROX is not set
> -CONFIG_FB_RADEON=m
> -CONFIG_FB_RADEON_I2C=y
> -CONFIG_FB_RADEON_BACKLIGHT=y
> -CONFIG_FB_RADEON_DEBUG=y
> +# CONFIG_FB_RADEON is not set
>   # CONFIG_FB_ATY128 is not set
>   # CONFIG_FB_ATY is not set
>   # CONFIG_FB_S3 is not set
> @@ -3809,13 +3799,12 @@
>   # CONFIG_FB_ARK is not set
>   # CONFIG_FB_PM3 is not set
>   # CONFIG_FB_CARMINE is not set
> -CONFIG_FB_SMSCUFX=m
> -CONFIG_FB_UDL=m
> -CONFIG_FB_IBM_GXT4500=m
> +# CONFIG_FB_SMSCUFX is not set
> +# CONFIG_FB_UDL is not set
> +# CONFIG_FB_IBM_GXT4500 is not set
>   # CONFIG_FB_VIRTUAL is not set
>   # CONFIG_FB_METRONOME is not set
>   # CONFIG_FB_MB862XX is not set
> -CONFIG_FB_SIMPLE=y
>   # CONFIG_FB_SSD1307 is not set
>   # CONFIG_FB_SM712 is not set
>   # end of Frame buffer Devices
> @@ -3838,7 +3827,6 @@
>   CONFIG_BACKLIGHT_ARCXCNN=m
>   # end of Backlight & LCD device support
> 
> -CONFIG_VGASTATE=m
>   CONFIG_HDMI=y
> 
>   #
> @@ -4553,8 +4541,10 @@
>   CONFIG_VIRTIO_INPUT=m
>   # CONFIG_VIRTIO_MMIO is not set
>   # CONFIG_VDPA is not set
> +CONFIG_VHOST_IOTLB=m
> +CONFIG_VHOST=m
>   CONFIG_VHOST_MENU=y
> -# CONFIG_VHOST_NET is not set
> +CONFIG_VHOST_NET=m
>   # CONFIG_VHOST_SCSI is not set
>   # CONFIG_VHOST_VSOCK is not set
>   # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> @@ -4586,9 +4576,8 @@
>   # CONFIG_FUJITSU_LAPTOP is not set
>   # CONFIG_FUJITSU_TABLET is not set
>   # CONFIG_GPD_POCKET_FAN is not set
> -# CONFIG_HP_ACCEL is not set
> +# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
>   # CONFIG_WIRELESS_HOTKEY is not set
> -# CONFIG_HP_WMI is not set
>   # CONFIG_IBM_RTL is not set
>   # CONFIG_SENSORS_HDAPS is not set
>   # CONFIG_THINKPAD_LMI is not set
> @@ -5513,20 +5502,9 @@
>   CONFIG_GENERIC_GETTIMEOFDAY=y
>   CONFIG_GENERIC_VDSO_TIME_NS=y
>   CONFIG_FONT_SUPPORT=y
> -CONFIG_FONTS=y
> +# CONFIG_FONTS is not set
>   CONFIG_FONT_8x8=y
>   CONFIG_FONT_8x16=y
> -# CONFIG_FONT_6x11 is not set
> -CONFIG_FONT_7x14=y
> -CONFIG_FONT_PEARL_8x8=y
> -CONFIG_FONT_ACORN_8x8=y
> -CONFIG_FONT_MINI_4x6=y
> -# CONFIG_FONT_6x10 is not set
> -CONFIG_FONT_10x18=y
> -CONFIG_FONT_SUN8x16=y
> -CONFIG_FONT_SUN12x22=y
> -CONFIG_FONT_TER16x32=y
> -# CONFIG_FONT_6x8 is not set
>   CONFIG_SG_POOL=y
>   CONFIG_ARCH_HAS_PMEM_API=y
>   CONFIG_MEMREGION=y
> ```
> 
> We selected `FB_EFI` again [4], and on another desktop system Dell 
> OptiPlex 7021 with Intel IGD and Nvidia DGPU, that fixed the problem. Do 
> you have any idea, what could be going wrong on this workstation?

Looking at that system, although it works, there are no efifb messages 
besides

     [    0.000000] Linux version 5.15.131.mx64.457 
(root@invidia.molgen.mpg.de) (gcc (GCC) 10.4.0, GNU ld (GNU Binutils) 
2.41) #1 SMP Tue Sep 12 12:55:20 CEST 2023
     […]
     [    0.000000] DMI: Dell Inc. OptiPlex 7071/097YXY, BIOS 1.1.2 
08/29/2019
     […]
     [    2.324031] pci 0000:01:00.0: BAR 3: assigned to efifb

either (which is the Intel IGD, where nothing is connected to), and the 
simpledrm are only shown.


Kind regards,

Paul


> [1]: https://fedoraproject.org/wiki/Changes/ReplaceFbdevDrivers
> [2]: https://github.molgen.mpg.de/mariux64/linux/blob/mariux-5.15.112-449/config-mpi
> [3]: https://github.molgen.mpg.de/mariux64/linux/blob/mariux-5.15.131-457/config-mpi
> [4]: https://lore.kernel.org/dri-devel/87bkf5g89v.fsf@minerva.mail-host-address-is-not-set/T/#t
