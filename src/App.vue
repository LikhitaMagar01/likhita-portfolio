<script setup lang="ts">
import { ref } from 'vue'
import profile from './data/profile'
import BottomBar from './components/BottomBar.vue'

const selectedSection = ref('home')

function handleSectionChange(section: string) {
  selectedSection.value = section
}
</script>

<template>
  <div class="min-h-screen bg-gradient-to-br from-gray-900 via-gray-800 to-gray-900 text-white flex flex-col items-center justify-center p-4 relative">
    <div class="w-full max-w-7xl m-auto">
      <div class="flex flex-col lg:flex-row items-start justify-center gap-4">
        <div
          class="relative bg-gray-800/50 backdrop-blur-sm border border-gray-700/50 rounded-3xl shadow-2xl p-0 w-full max-w-sm flex flex-col items-center lg:sticky lg:top-8 overflow-hidden m-auto">
          <div class="absolute right-0 top-6 bottom-6 w-1 bg-gradient-to-b from-green-400 to-emerald-600 rounded-full"></div>
          <div class="flex flex-col items-center w-full px-8 py-8 z-10">
            <div class="relative mb-6">
              <img :src="profile.image" alt="Profile"
                class="rounded-2xl w-32 h-32 object-cover border-4 border-green-500/30 shadow-xl" />
              <div class="absolute -bottom-2 -right-2 w-6 h-6 bg-green-500 rounded-full border-4 border-gray-800"></div>
            </div>
            <h2 class="text-xl font-bold mb-1">{{ profile.name }}</h2>
            <p class="text-green-400 text-sm font-medium mb-6">{{ profile.title }}</p>
            <div class="flex space-x-4 my-4">
              <a v-for="s in profile.social" :key="s.icon" :href="s.url" target="_blank"
                class="text-gray-400 hover:text-green-400 text-xl transition-colors duration-300">
                <i v-if="s.icon === 'fa-github'" class="ri-github-fill"></i>
                <i v-if="s.icon === 'fa-linkedin'" class="ri-linkedin-box-fill"></i>
              </a>
            </div>
            <div class="w-full space-y-2 mb-6">
              <div class="flex items-center text-sm text-gray-300">
                <i class="ri-mail-line text-green-400 mr-2"></i>
                {{ profile.email }}
              </div>
              <div class="flex items-center text-sm text-gray-300">
                <i class="ri-map-pin-line text-green-400 mr-2"></i>
                {{ profile.location }}
              </div>
            </div>
            <a
              href="mailto:leekhitame@gmail.com"
              class="bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white px-6 py-3 rounded-xl w-full font-semibold flex items-center justify-center gap-2 no-underline transition-all duration-300 shadow-lg hover:shadow-green-500/25">
              <svg style="width: 20px; height: 20px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M3 3H21C21.5523 3 22 3.44772 22 4V20C22 20.5523 21.5523 21 21 21H3C2.44772 21 2 20.5523 2 20V4C2 3.44772 2.44772 3 3 3ZM12.0606 11.6829L5.64722 6.2377L4.35278 7.7623L12.0731 14.3171L19.6544 7.75616L18.3456 6.24384L12.0606 11.6829Z"></path></svg> {{ profile.contactButton }}
            </a>
            <div class="text-xs text-gray-500 mt-6">{{ profile.copyright }}</div>
          </div>
        </div>
        <div class="flex-1 w-full max-w-3xl flex flex-col gap-4 sm:pb-0 m-auto">
          <div class="bg-gray-800/30 backdrop-blur-sm border border-gray-700/50 rounded-3xl p-8 shadow-xl">
            <section v-if="selectedSection === 'home'" class="flex flex-col gap-6">
              <div class="text-green-400 text-sm font-medium tracking-wide uppercase">Introduction</div>
              <h1 class="text-4xl sm:text-5xl lg:text-6xl font-bold leading-tight">
                {{ profile.intro }}
                <span class="text-transparent bg-clip-text bg-gradient-to-r from-green-400 to-emerald-500">{{ profile.highlightedName }}</span>,<br>
                <span v-for="(role, i) in profile.roles" :key="role" class="font-semibold text-gray-300">
                  {{ role }}<span v-if="i < profile.roles.length - 1"> | </span>
                </span>
              </h1>
              <p class="text-gray-300 text-lg leading-relaxed">{{ profile.description }}</p>
            </section>
            <section v-if="selectedSection === 'about'" class="flex flex-col gap-6">
              <h2 class="text-3xl font-bold mb-2">About Me</h2>
              <p class="text-gray-300 text-lg leading-relaxed mb-6" v-html="profile.about.introduction"></p>
              <h3 class="text-xl font-semibold mb-3 text-green-400">Technical Expertise</h3>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-3 mb-6">
                <div v-for="(item, idx) in profile.about.technicalExpertise" :key="idx" class="bg-gray-700/30 rounded-lg p-3 border border-gray-600/30">
                  <div class="text-green-400 font-medium mb-1">{{ item.title }}</div>
                  <div class="text-sm text-gray-400">{{ item.skills }}</div>
                </div>
              </div>
              <p class="text-gray-400 text-base leading-relaxed" v-html="profile.about.personal"></p>
            </section>
            <section v-if="selectedSection === 'education'" class="flex flex-col gap-6">
              <div class="flex items-center mb-2">
                <span class="bg-green-500/10 text-green-400 text-xs px-3 py-1 rounded-full border border-green-500/30">Education</span>
              </div>
              <h2 class="text-3xl font-bold mb-6">Education</h2>
              <div class="space-y-6">
                <div v-for="(item, idx) in profile.education" :key="'edu-' + idx" class="bg-gray-700/30 rounded-xl p-5 border border-gray-600/30 hover:border-green-500/30 transition-all duration-300">
                  <div class="text-green-400 text-sm font-medium mb-2">{{ item.date }}</div>
                  <div class="text-lg font-semibold text-white leading-tight mb-1">{{ item.title }}</div>
                  <div v-if="'subtitle' in item && item.subtitle" class="text-gray-400 text-sm">{{ item.subtitle }}</div>
                </div>
              </div>
            </section>
            <section v-if="selectedSection === 'experience'" class="flex flex-col gap-6">
              <div class="flex items-center mb-2">
                <span class="bg-green-500/10 text-green-400 text-xs px-3 py-1 rounded-full border border-green-500/30">Experience</span>
              </div>
              <h2 class="text-3xl font-bold mb-6">Work Experience</h2>
              <div class="space-y-6">
                <div v-for="(item, idx) in profile.experience" :key="'exp-' + idx" class="bg-gray-700/30 rounded-xl p-5 border border-gray-600/30 hover:border-green-500/30 transition-all duration-300">
                  <div class="text-green-400 text-sm font-medium mb-2">{{ item.date }}</div>
                  <div class="text-lg font-semibold text-white leading-tight mb-1">{{ item.title }}</div>
                  <div v-if="'company' in item && item.company" class="text-green-400 text-sm font-medium">{{ item.company }}</div>
                </div>
              </div>
            </section>
            <section v-if="selectedSection === 'projects'" class="flex flex-col gap-6">
              <h2 class="text-3xl font-bold mb-2">Production Projects</h2>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div v-for="project in profile.productionProjects" :key="project.name" class="bg-gray-700/30 rounded-xl p-5 border border-gray-600/30 hover:border-green-500/30 transition-all duration-300 flex flex-col gap-3">
                  <div class="flex items-start justify-between">
                    <h3 class="text-lg font-semibold text-white">{{ project.name }}</h3>
                    <a v-if="project.link" :href="project.link" target="_blank" class="text-green-400 hover:text-green-300 transition-colors">
                      <i class="ri-external-link-line text-sm">Visit link</i>
                    </a>
                  </div>
                  <p class="text-gray-300 text-sm leading-relaxed">{{ project.description }}</p>
                  <div v-if="project.tech" class="flex flex-wrap gap-2 mt-auto">
                    <span v-for="tech in project.tech" :key="tech" class="text-xs bg-green-500/10 text-green-400 px-2 py-1 rounded border border-green-500/30">{{ tech }}</span>
                  </div>
                </div>
              </div>
              <h2 class="text-3xl font-bold mb-2 mt-8">Personal Projects</h2>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                <div v-for="project in profile.personalProjects" :key="project.name" class="bg-gray-700/30 rounded-xl p-5 border border-gray-600/30 hover:border-green-500/30 transition-all duration-300 flex flex-col gap-3">
                  <div class="flex items-start justify-between">
                    <h3 class="text-lg font-semibold text-white">{{ project.name }}</h3>
                    <a v-if="project.link" :href="project.link" target="_blank" class="text-green-400 hover:text-green-300 transition-colors">
                      <i class="ri-external-link-line text-sm">Visit link</i>
                    </a>
                  </div>
                  <p class="text-gray-300 text-sm leading-relaxed">{{ project.description }}</p>
                  <div v-if="project.tech" class="flex flex-wrap gap-2 mt-auto">
                    <span v-for="tech in project.tech" :key="tech" class="text-xs bg-green-500/10 text-green-400 px-2 py-1 rounded border border-green-500/30">{{ tech }}</span>
                  </div>
                </div>
              </div>
            </section>
            <section v-if="selectedSection === 'skills'" class="flex flex-col gap-6">
              <h2 class="text-3xl font-bold mb-2">Technical Skills</h2>
              <div class="grid grid-cols-3 sm:grid-cols-4 md:grid-cols-5 lg:grid-cols-6 gap-4">
                <div v-for="skill in profile.skills" :key="skill.name" class="flex flex-col items-center bg-gray-700/30 rounded-xl p-4 border border-gray-600/30 hover:border-green-500/30 transition-all duration-300">
                  <img :src="skill.icon" :alt="skill.name" class="w-10 h-10 mb-2" />
                  <span class="text-xs text-center text-gray-300">{{ skill.name }}</span>
                </div>
              </div>
            </section>
            <section v-if="selectedSection === 'contact'" class="flex flex-col gap-6">
              <h2 class="text-3xl font-bold mb-2">{{ profile.contact.title }}</h2>
              <p class="text-gray-300 text-lg mb-6">{{ profile.contact.description }}</p>
              <div class="space-y-4">
                <div v-for="contact in profile.contacts" :key="contact.type" class="flex items-center bg-gray-700/30 rounded-xl p-4 border border-gray-600/30 hover:border-green-500/30 transition-all duration-300">
                  <i :class="[contact.icon, 'text-green-400 mr-4 text-xl']"></i>
                  <template v-if="contact.link">
                    <a :href="contact.link" class="text-gray-300 hover:text-green-400 transition-colors" target="_blank">{{ contact.value }}</a>
                  </template>
                  <template v-else>
                    <span class="text-gray-300">{{ contact.value }}</span>
                  </template>
                </div>
              </div>
            </section>
          </div>
          <BottomBar :selectedSection="selectedSection" @section-change="handleSectionChange" />
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
section.overflow-y-auto {
  scrollbar-width: thin;
  scrollbar-color: #222 #111;
}

section.overflow-y-auto::-webkit-scrollbar {
  width: 8px;
  background: #111;
}

section.overflow-y-auto::-webkit-scrollbar-thumb {
  background: #222;
  border-radius: 6px;
}
</style>
